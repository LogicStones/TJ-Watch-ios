//
//  ServiceListVC.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 30/12/2021.
//

import UIKit
import RappleProgressHUD
import SDWebImage
import Alamofire
import CropViewController

class ServiceListVC: UIViewController, UIImagePickerControllerDelegate & UIViewControllerTransitioningDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var lblTotalRecord: UILabel!
    @IBOutlet weak var btnProcess: UIButton!
    @IBOutlet weak var btnComplete: UIButton!
    @IBOutlet weak var tblService: UITableView!
    
    @IBOutlet weak var imgWatch: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSerialNo: UILabel!
    @IBOutlet weak var lblReturnDate: UILabel!
    @IBOutlet weak var lblTypeOfProblem: UILabel!
    @IBOutlet weak var lblPaymentType: UILabel!
    @IBOutlet weak var lblCustomerName: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblRemainingAmount: UILabel!
    @IBOutlet weak var txtRemAmount: UITextField!
    @IBOutlet weak var btnMarkComplete: UIButton!
    @IBOutlet weak var vwDateMark: UIView!
    @IBOutlet weak var vwMark: UIView!
    @IBOutlet weak var vwMarkContent: UIView!
    @IBOutlet weak var vwEnpty: UIView!
    @IBOutlet weak var imgNoData: UIImageView!
    
    @IBOutlet weak var vwCash: UIView!
    @IBOutlet weak var vwCashPrice: UIView!
    @IBOutlet weak var txtCash: UITextField!
    
    @IBOutlet weak var vwCard: UIView!
    @IBOutlet weak var vwCardPrice: UIView!
    @IBOutlet weak var vwCardImage: UIView!
    @IBOutlet weak var imgCard: UIImageView!
    @IBOutlet weak var txtCard: UITextField!
    
    @IBOutlet weak var vwWire: UIView!
    @IBOutlet weak var vwWirePrice: UIView!
    @IBOutlet weak var vwWireImage: UIView!
    @IBOutlet weak var txtWire: UITextField!
    @IBOutlet weak var imgWire: UIImageView!
    
    @IBOutlet weak var vwCrypto: UIView!
    @IBOutlet weak var vwCryptoPrice: UIView!
    @IBOutlet weak var txtCrypto: UITextField!
    @IBOutlet weak var vwCryptoImage: UIView!
    @IBOutlet weak var imgCrypto: UIImageView!
    
    
    let colr =  UIColor(red: 18/255, green: 78/255, blue: 68/255, alpha: 1.0)
    var arrServie:[ServiceList] = []
    var statusService = "inprocess"
    var selectedService:ServiceList!
    var imgSelectedCard:UIImage!
    var imgSelectedWire:UIImage!
    var imgSelectedCrypto:UIImage!
    var selectingImgType = -1
    var imagePicker: UIImagePickerController!
    var alamoFireManager : Session?
    let refreshControl = UIRefreshControl()
    var selectedServiceID = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.imagePicker = UIImagePickerController()
        self.imgNoData.setImgTintColor(colr: UIColor.lightGray)
        // self.btnProcess.vwCornerRadius(radius: 18)
        //   self.btnComplete.vwCornerRadius(radius: 18)
        self.btnComplete.backgroundColor = UIColor.white
        self.btnComplete.setTitleColor(self.colr, for: .normal)
        self.btnComplete.vwBorderRadius(color: self.colr , bordrWidth: 1, radius: 18)
        self.btnProcess.vwBorderRadius(color: self.colr, bordrWidth: 1, radius: 18)
        self.tblService.delegate = self
        self.tblService.dataSource = self
        self.txtRemAmount.setBrdBg()
        self.txtRemAmount.delegate = self
        self.txtCard.delegate = self
        self.txtCash.delegate = self
        self.txtWire.delegate = self
        self.txtCrypto.delegate = self
        self.btnMarkComplete.vwCornerRadius(radius: 18)
        self.vwDateMark.topCornerRadius(radius: 12)
        self.btnMarkComplete.addTarget(self, action: #selector(self.completeOrder), for: .touchUpInside)
        self.btnComplete.addTarget(self, action: #selector(self.getCompletedOrders), for: .touchUpInside)
        self.btnProcess.addTarget(self, action: #selector(self.getInProcessOrders), for: .touchUpInside)
        self.getServicesLst()
        
        self.vwCash.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 12)
        self.vwCashPrice.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 12)
        self.vwCard.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 12)
        self.vwCardPrice.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 12)
        self.vwCardImage.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 12)
        self.vwWire.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 12)
        self.vwWireImage.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 12)
        self.vwWirePrice.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 12)
        self.vwCrypto.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 12)
        self.vwCryptoImage.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 12)
        self.vwCryptoPrice.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 12)
        self.vwMarkContent.vwCornerRadius(radius: 12)
        self.refreshControl.tintColor = Constants.appColors.green
        self.refreshControl.addTarget(self, action: #selector(self.refereshData), for: .valueChanged)
        self.tblService.addSubview(refreshControl)
        self.tblService.alwaysBounceVertical = true
    }
    
    @IBAction func btnBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func refereshData()
    {
        self.getServicesLst()
    }
    
    @objc private func getCompletedOrders()
    {
        self.statusService = "done"
        self.btnComplete.backgroundColor = self.colr
        self.btnComplete.setTitleColor(UIColor.white, for: .normal)
        self.btnProcess.backgroundColor = UIColor.white
        self.btnProcess.setTitleColor(self.colr, for: .normal)
        self.getServicesLst()
    }
    
    @objc private func getInProcessOrders()
    {
        self.btnComplete.backgroundColor = UIColor.white
        self.btnComplete.setTitleColor(self.colr, for: .normal)
        self.btnProcess.backgroundColor = self.colr
        self.btnProcess.setTitleColor(UIColor.white, for: .normal)
        self.statusService = "inprocess"
        self.getServicesLst()
    }
    
    @IBAction func btnHideMarkComplt(_ sender: Any) {
        self.vwMark.isHidden = true
    }
    
    @IBAction func btnSelectCardPriceImg(_ sender: Any)
    {
        let sndr = sender as! UIButton
        sndr.tag = 3
        self.openCamera(snder: sndr)
    }
    
    @IBAction func btnSelectWirePriceImg(_ sender: Any)
    {
        let sndr = sender as! UIButton
        sndr.tag = 4
        self.openCamera(snder: sndr)
    }
    
    @IBAction func btnSelectCryptpPriceImage(_ sender: Any)
    {
        let sndr = sender as! UIButton
        sndr.tag = 5
        self.openCamera(snder: sndr)
    }
    
    @objc private func openCamera(snder:UIButton)
    {
        self.selectingImgType = snder.tag
        let alertOptionCamera: UIAlertController = UIAlertController(title: "Please Select", message:nil, preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            
        }
        alertOptionCamera.addAction(cancelActionButton)
        
        
        let saveActionButton = UIAlertAction(title: "Take Photo", style: .default)
        { _ in
            //var imagePicker = UIImagePickerController()
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = .camera;
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        alertOptionCamera.addAction(saveActionButton)
        
        let deleteActionButton = UIAlertAction(title: "Choose Photo", style: .default)
        { _ in
            
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = .photoLibrary;
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
            
        }
        alertOptionCamera.addAction(deleteActionButton)
        self.present(alertOptionCamera, animated: true, completion: nil)
        //        imagePicker =  UIImagePickerController()
        //        imagePicker.delegate = self
        //        imagePicker.sourceType = .camera
        //        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let selectedImage =  info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            switch self.selectingImgType
            {
            case 3:
                self.imgCard.image = selectedImage
                self.imgSelectedCard = selectedImage
                break
            case 4:
                self.imgWire.image = selectedImage
                self.imgSelectedWire = selectedImage
                break
            case 5:
                self.imgCrypto.image = selectedImage
                self.imgSelectedCrypto = selectedImage
                break
            default:
                break
            }
            self.imagePicker.dismiss(animated: true, completion: nil)
            // self.selectingImgType = -1
            self.cropImageUsingCroper(selectedImage: selectedImage)
        }
    }
    
    private func cropImageUsingCroper(selectedImage:UIImage)
    {
        let cropview = CropViewController(image: selectedImage)
        cropview.delegate = self
        self.present(cropview, animated: false, completion: nil)
    }
    
    @IBAction func btnNotifications(_ sender: Any) {
        let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vw, animated: true)
    }
}

extension ServiceListVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrServie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblService.dequeueReusableCell(withIdentifier: "ServiceListCell", for: indexPath) as! ServiceListCell
        let srvc = self.arrServie[indexPath.row]
        cell.imgWatch.sd_setImage(with: URL(string: srvc.image), placeholderImage: UIImage(named: "placeholder"))
        cell.lblName.text = srvc.custName
        cell.lblSerialNo.text = srvc.serialNo
        cell.lblCustomerName.text = srvc.make
        cell.lblModel.text = srvc.model
        cell.lblTypeOfProblem.text = srvc.typeOfProblem
        cell.lblReturnDate.text = srvc.returnDT
        cell.lblTotalPrice.text = "£"+srvc.serviceCharges
        cell.lblRemainingPrice.text = "£"+srvc.balPayment
        cell.lblAdvance.text =  srvc.advancePayType
        cell.btnEditService.tag = indexPath.row + 300
        cell.btnEditService.addTarget(self, action: #selector(self.editService(sender:)), for: .touchUpInside)
        //cell.lblAdvance.text = srvc.t
        if self.statusService == "inprocess"
        {
            cell.btnMarkComplete.addTarget(self, action: #selector(self.OrderServiceComplete(sender:)), for: .touchUpInside)
            cell.btnMarkComplete.tag = indexPath.row + 100
            cell.btnMarkComplete.isHidden = false
            cell.lblStatusReslt.isHidden = false
            cell.lblOrderStatus.isHidden = false
            if SharedManager.sharedInstance.userData.isAdmin.lowercased() == "false"
            {
                cell.lblAssignUserCap.isHidden = true
                cell.lblAssignUser.isHidden = true
                cell.btnAssign.isHidden = true
                //cell.ed
            }
            else
            {
                cell.lblAssignUserCap.isHidden = false
                cell.lblAssignUser.isHidden = false
                cell.lblAssignUser.text = srvc.userName
                cell.btnAssign.isHidden = false
                cell.btnAssign.tag = indexPath.row + 200
                cell.btnAssign.addTarget(self, action: #selector(self.assignToUser(sndr:)), for: .touchUpInside)
            }
        }
        else
        {
            cell.btnMarkComplete.isHidden = true
            cell.lblStatusReslt.isHidden = true
            cell.lblOrderStatus.isHidden = true
            cell.lblAssignUserCap.isHidden = true
            cell.lblAssignUser.isHidden = true
            cell.btnAssign.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if self.statusService == "inprocess"
        {
            return 290
        }
        else
        {
            return 230
        }
    }
    
    @objc private func OrderServiceComplete(sender:UIButton)
    {
        let srvc = self.arrServie[sender.tag - 100]
        self.selectedService = srvc
        self.lblName.text = srvc.make + " " + srvc.model
        self.imgWatch.sd_setImage(with: URL(string: srvc.image), placeholderImage: UIImage(named: "placeholder"))
        self.lblName.text = srvc.make + " " + srvc.model
        self.lblSerialNo.text = srvc.serialNo
        self.lblCustomerName.text = srvc.custName
        self.lblTypeOfProblem.text = srvc.typeOfProblem
        self.lblReturnDate.text = srvc.returnDT
        self.lblTotalPrice.text = "£"+srvc.serviceCharges
        self.lblRemainingAmount.text = "£"+srvc.balPayment
        self.lblPaymentType.text = srvc.advancePayType
        self.vwMark.isHidden = false
    }
    
    @objc private func assignToUser(sndr:UIButton)
    {
        let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SalemanVC") as! SalemanVC
        vw.delegate = self
        self.selectedServiceID = self.arrServie[sndr.tag - 200].serviceID
        vw.modalPresentationStyle = .overCurrentContext
        self.present(vw, animated: true, completion: nil)
    }
    
    @objc private func editService(sender:UIButton)
    {
        let srvc = self.arrServie[sender.tag - 300]
        let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddServiceVC") as! AddServiceVC
        vw.serviceID = srvc.serviceID
        vw.modalPresentationStyle = .overFullScreen
        self.present(vw, animated: true, completion: nil)
    }
    
    @objc private func completeOrder()
    {
        if self.txtRemAmount.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Please enter remaining amount"), animated: true, completion: nil)
            return
        }
        else if Double(self.txtRemAmount.text!.replacingOccurrences(of: ",", with: ""))! != Double(self.selectedService.balPayment.replacingOccurrences(of: ",", with: ""))!
        {
            self.present(ActionHandler.showAlert(message: "Please enter correct remaining amount"), animated: true, completion: nil)
            return
        }
        if self.imgSelectedCard != nil && self.txtCard.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Please enter card payment"), animated: true, completion: nil)
            return
        }
        if self.txtCard.text != "" && self.imgSelectedCard == nil
        {
            self.present(ActionHandler.showAlert(message: "Please take/choose card picture"), animated: true, completion: nil)
            return
        }
        if self.imgSelectedWire != nil && self.txtWire.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Please enter wire payment"), animated: true, completion: nil)
            return
        }
        if self.txtWire.text != "" && self.imgSelectedWire == nil
        {
            self.present(ActionHandler.showAlert(message: "Please take/choose wire picture"), animated: true, completion: nil)
            return
        }
        if self.imgSelectedCrypto != nil && self.txtCrypto.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Please enter crypto payment"), animated: true, completion: nil)
            return
        }
        if self.txtCrypto.text != "" && self.imgSelectedCrypto == nil
        {
            self.present(ActionHandler.showAlert(message: "Please take/choose crypto picture"), animated: true, completion: nil)
            return
        }
        self.completeOrderService()
    }
    
}
extension ServiceListVC //get data
{
    private func getServicesLst()
    {
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
        getAllServiceSer(servicestatus: self.statusService) { response in
            switch(response.result)
            {
            case .success(_):
                RappleActivityIndicatorView.stopAnimation()
                self.refreshControl.endRefreshing()
                if let _JSON = response.data
                {
                    if let json = try! JSONSerialization.jsonObject(with: _JSON) as? [String:Any]
                    {
                        if json["error"] as! Bool
                        {
                            if let msg = json["message"] as? String
                            {
                                self.present(ActionHandler.showAlertPopViewController(message: msg, vw: self), animated: true, completion: nil)
                                //  self.present(ActionHandler.showAlert(message: msg), animated: true, completion: nil)
                            }
                            else
                            {
                                self.present(ActionHandler.showAlert(message: Constants.messgs.somethingWrong), animated: true, completion: nil)
                            }
                        }
                        else
                        {
                            if let dt = json["data"] as? [[String:Any]]
                            {
                                self.arrServie = []
                                for mk in dt
                                {
                                    let servc = ServiceList.fromJSON(mk)
                                    self.arrServie.append(servc)
                                }
                                if self.arrServie.count == 0
                                {
                                    self.vwEnpty.isHidden = false
                                    self.tblService.isHidden = true
                                }
                                else
                                {
                                    self.vwEnpty.isHidden = true
                                    self.tblService.isHidden = false
                                }
                                self.tblService.reloadData()
                            }
                        }
                    }
                }
                break
            case .failure(_):
                RappleActivityIndicatorView.stopAnimation()
                self.present(ActionHandler.showAlert(message: Constants.messgs.somethingWrong), animated: true, completion: nil)
                break
            }
        }
    }
}

extension ServiceListVC //mark as complete
{
    private func completeOrderService()
    {
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
        let parameter = ["ServiceId":self.selectedService.serviceID,
                         "BalPayment":self.txtRemAmount.text!,
                         "Card":self.txtCard.text!,
                         "Cash":self.txtCash.text!,
                         "Crypto":self.txtCrypto.text!,
                         "Wire":self.txtWire.text!,
        ]
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 100
        configuration.timeoutIntervalForResource = 100
        
        alamoFireManager = Alamofire.Session(configuration: configuration)
        alamoFireManager!.upload(multipartFormData: { multipartFormData in
            
            if self.imgSelectedCard != nil
            {
                let card = self.imgSelectedCard.jpegData(compressionQuality: 0.3)!
                multipartFormData.append(card, withName: "ImgCard",fileName: "ImgCard.jpg", mimeType: "image/jpg")
            }
            if self.imgSelectedWire != nil
            {
                let wire = self.imgSelectedWire.jpegData(compressionQuality: 0.3)!
                multipartFormData.append(wire, withName: "ImgWire",fileName: "ImgWire.jpg", mimeType: "image/jpg")
            }
            if self.imgSelectedCrypto != nil
            {
                let crypto = self.imgSelectedCrypto.jpegData(compressionQuality: 0.3)!
                multipartFormData.append(crypto, withName: "ImgCrypto",fileName: "ImgCrypto.jpg", mimeType: "image/jpg")
            }
            
            for (key, value) in parameter {
                multipartFormData.append(((value).data(using: String.Encoding.utf8)!), withName: key)
            }
        },
                                 to: Constants.Server.baseUrl+"/JewelleryApi/CompleteTheService", usingThreshold: UInt64.init(), method: .post, headers: [:]).responseJSON{(response) in
            switch response.result {
            case .success(_):
                RappleActivityIndicatorView.stopAnimation()
                do {
                    print(response)
                    if response.data != nil
                    {
                        let json = try JSONSerialization.jsonObject(with: response.data!) as! [String: Any]
                        let error = json["error"] as! Bool
                        if !error {
                            if let msg = json["message"] as? String
                            {
                                self.fieldDataRemove()
                                self.present(ActionHandler.showAlert(message: msg), animated: true, completion: nil)
                                self.getServicesLst()
                                self.getInProcessOrders()
                                self.vwMark.isHidden = true
                            }
                        }
                    }
                }catch{}
                break
            case .failure(let encodingError):
                RappleActivityIndicatorView.stopAnimation()
            }
        }
    }
    
    private func fieldDataRemove()
    {
        self.imgWire.image = UIImage(named: "Sample_image")
        self.imgCard.image = UIImage(named: "Sample_image")
        self.imgCrypto.image = UIImage(named: "Sample_image")
        self.imgSelectedWire = nil
        self.imgSelectedCard = nil
        self.imgSelectedCrypto = nil
        self.txtCash.text = ""
        self.txtCard.text = ""
        self.txtWire.text = ""
        self.txtCrypto.text = ""
        self.txtRemAmount.text = ""
    }
}
extension ServiceListVC:UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if string == ""
        {
            // User presses backspace
            textField.deleteBackward()
        } else {
            // User presses a key or pastes
            if self.txtRemAmount == textField || textField == self.txtCash || textField == self.txtCard || textField == self.txtWire || self.txtCrypto == textField
            {
                print("Text:: \(textField.text!)")
                let commaStr = ActionHandler.addComma(amount: textField.text! == "" ? string : textField.text!+string)
                print("comma Separated:: \(commaStr)")
                textField.text = commaStr
            }
            else
            {
                textField.insertText(string.uppercased())
            }
        }
        // Do not let specified text range to be changed
        return false
    }
}
extension ServiceListVC:CropViewControllerDelegate
{
    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool)
    {
        //self.imgWatch = image
        print("Croping cancelled \(cancelled)")
        cropViewController.dismiss(animated: true, completion: nil)
    }
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int)
    {
        switch self.selectingImgType
        {
        case 3:
            self.imgCard.image = image
            self.imgSelectedCard = image
            break
        case 4:
            self.imgWire.image = image
            self.imgSelectedWire = image
            break
        case 5:
            self.imgCrypto.image = image
            self.imgSelectedCrypto = image
            break
        default:
            break
        }
        self.selectingImgType = -1
        cropViewController.dismiss(animated: true, completion: nil)
    }
}
extension ServiceListVC:salesmanProtocol
{
    func selectSalesman(saleman: Salesman) {
        self.assignToSelectedSalesman(id: saleman.id)
    }
    
    private func assignToSelectedSalesman(id:String)
    {
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
        serviceAssignToSalesmanSer(serviceId: self.selectedServiceID, userId: id) { response in
            switch(response.result)
            {
            case .success(_):
                RappleActivityIndicatorView.stopAnimation()
                self.refreshControl.endRefreshing()
                if let _JSON = response.data
                {
                    if let json = try! JSONSerialization.jsonObject(with: _JSON) as? [String:Any]
                    {
                        if json["error"] as! Bool
                        {
                            if let msg = json["message"] as? String
                            {
                                self.present(ActionHandler.showAlertPopViewController(message: msg, vw: self), animated: true, completion: nil)
                                //  self.present(ActionHandler.showAlert(message: msg), animated: true, completion: nil)
                            }
                            else
                            {
                                self.present(ActionHandler.showAlert(message: Constants.messgs.somethingWrong), animated: true, completion: nil)
                            }
                        }
                        else
                        {
                            self.present(ActionHandler.showAlert(message: "Salesman successfully assigned"), animated: true, completion: nil)
                            self.getServicesLst()
                        }
                    }
                }
                break
            case .failure(_):
                RappleActivityIndicatorView.stopAnimation()
                self.present(ActionHandler.showAlert(message: Constants.messgs.somethingWrong), animated: true, completion: nil)
                break
            }
        }
    }
}
