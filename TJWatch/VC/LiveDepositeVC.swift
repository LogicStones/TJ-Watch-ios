//
//  LiveDepositeVC.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 31/01/2022.
//

import UIKit
import RappleProgressHUD
import Alamofire
import CropViewController

class LiveDepositeVC: UIViewController,UIImagePickerControllerDelegate, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var tblLiveDeposit: UITableView!
    @IBOutlet weak var imgNoData: UIImageView!
    @IBOutlet weak var vwEmpty: UIView!
    
    @IBOutlet weak var imgWatch: UIImageView!
    @IBOutlet weak var lblNameWatch: UILabel!
    @IBOutlet weak var lblSerialNo: UILabel!
    @IBOutlet weak var lblModel: UILabel!
    @IBOutlet weak var lblMatirial: UILabel!
    @IBOutlet weak var lblUkWatchNo: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblDail: UILabel!
    @IBOutlet weak var lblClientName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblContactNumbe: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblAdvPrice: UILabel!
    @IBOutlet weak var txtRemainingPrice: UITextField!
    @IBOutlet weak var btnSellOrder: UIButton!
    
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
    
    @IBOutlet weak var vwSellLiveOrder: UIView!
    @IBOutlet weak var vwSellLiveOrderContant: UIView!
    
    var arrLiveDeposit:[LiveDeposit] = []
    var liveDeposit:LiveDeposit!
    var sort = "asc"
    var imagePicker: UIImagePickerController!
    var alamoFireManager : Session?
    var selectingImgType = -1
    var imgSelectedCard:UIImage!
    var imgSelectedWire:UIImage!
    var imgSelectedCrypto:UIImage!
    var imgSelectProofID:UIImage!
    var imgSelectProofAddress:UIImage!
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.imagePicker = UIImagePickerController()
        self.imgNoData.setImgTintColor(colr: UIColor.lightGray)
        self.getAllOrder(sort:sort)
        self.tblLiveDeposit.delegate = self
        self.tblLiveDeposit.dataSource = self
        self.btnSellOrder.vwCornerRadius(radius: 20)
        self.vwSellLiveOrderContant.vwCornerRadius(radius: 12)
        self.btnSellOrder.addTarget(self, action: #selector(self.liveOrderSell(sndr:)), for: .touchUpInside)
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
        self.txtRemainingPrice.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 8)
        self.txtRemainingPrice.delegate = self
        self.txtCash.delegate = self
        self.txtCard.delegate = self
        self.txtWire.delegate = self
        self.txtCrypto.delegate = self
        self.refreshControl.tintColor = Constants.appColors.green
        self.refreshControl.addTarget(self, action: #selector(self.refereshData), for: .valueChanged)
        self.tblLiveDeposit.addSubview(refreshControl)
        self.tblLiveDeposit.alwaysBounceVertical = true

    }
    
    @objc private func refereshData()
        {
            self.getAllOrder(sort: self.sort)
        }

    
    @IBAction func btnColseSell(_ sender: Any)
    {
        self.vwSellLiveOrder.isHidden = true
    }
    @IBAction func btnBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSorting(_ sender: Any)
    {
        if self.sort == "asc"
        {
            self.sort = "desc"
        }
        else
        {
            self.sort = "asc"
        }
        self.getAllOrder(sort: self.sort)
    }
    
    @objc private func liveOrderSell(sndr:UIButton)
    {
        if self.txtRemainingPrice.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Please enter remaining payment"), animated: true, completion: nil)
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
        self.sellLiveDepositOrder()
    }
    
    @IBAction func btnSelectCardPriceImg(_ sender: Any)
    {
        let sndr = sender as! UIButton
        sndr.tag = 1
        self.openCamera(snder: sndr)
    }
    
    @IBAction func btnSelectWirePriceImg(_ sender: Any)
    {
        let sndr = sender as! UIButton
        sndr.tag = 2
        self.openCamera(snder: sndr)
    }
    
    @IBAction func btnSelectCryptpPriceImage(_ sender: Any)
    {
        let sndr = sender as! UIButton
        sndr.tag = 3
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
            case 1:
                self.imgSelectedCard = selectedImage
                self.imgCard.image = selectedImage
                break
            case 2:
                self.imgSelectedWire = selectedImage
                self.imgWire.image = selectedImage
                break
            case 3:
                self.imgSelectedCrypto = selectedImage
                self.imgCrypto.image = selectedImage
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
}

extension LiveDepositeVC:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.arrLiveDeposit.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.tblLiveDeposit.dequeueReusableCell(withIdentifier: "SoldCell", for: indexPath) as! SoldCell
        let liv = self.arrLiveDeposit[indexPath.row]
        cell.lblName.text = liv.make + " " + liv.model
        cell.lblSerialNo.text = liv.serialNo
        cell.lblYear.text = liv.year
        cell.lblBuyerName.text = liv.clientName
        cell.lblBuyerContact.text = "£"+liv.price
        cell.lblEmail.text = "£"+liv.advancePayment
        cell.btnInvoice.tag = indexPath.row + 100
        cell.btnInvoice.addTarget(self, action: #selector(self.sellIive(sndr:)), for: .touchUpInside)
        cell.btnDel.tag = indexPath.row + 300
        cell.btnDel.addTarget(self, action: #selector(self.cancelOrder(sndr:)), for: .touchUpInside)
        cell.imgWatch.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "placeholder"))
        return cell
    }
    
    @objc private func sellIive(sndr:UIButton)
    {
        self.getOrderByID(id: self.arrLiveDeposit[sndr.tag - 100].liveDepositID)
        
    }
    
    @objc private func cancelOrder(sndr:UIButton)
    {
        let ordr = self.arrLiveDeposit[sndr.tag - 300]
        let alert = UIAlertController(title: "Alert!", message: "Are you sure you want to cancel this item?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { UIAlertAction in
            self.cancelLiveOrder(orderID: ordr.liveDepositID)
        }))
        alert.addAction(UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel, handler: { UIAlertAction in
        }))
        alert.view.tintColor = UIColor.black
        self.present(alert, animated: true, completion: nil)
    }
}

extension LiveDepositeVC //api
{
    private func getAllOrder(sort:String)
    {
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
        getAllLiveDepositSer(sort: sort) { response in
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
                            self.arrLiveDeposit = []
                            self.vwEmpty.isHidden = false
                            self.tblLiveDeposit.isHidden = true
                            self.tblLiveDeposit.reloadData()
                        }
                        else
                        {
                            if let dt = json["data"] as? [[String:Any]]
                            {
                                self.arrLiveDeposit = []
                                for lv in dt
                                {
                                    self.arrLiveDeposit.append(LiveDeposit.fromJSON(lv))
                                }
                                if self.arrLiveDeposit.count == 0
                                {
                                    self.vwEmpty.isHidden = false
                                    self.tblLiveDeposit.isHidden = true
                                }
                                else
                                {
                                    self.vwEmpty.isHidden = true
                                    self.tblLiveDeposit.isHidden = false
                                }
                                self.tblLiveDeposit.reloadData()
                                
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
    
    private func getOrderByID(id:String)
    {
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
        getLiveDepositByIDSer(id: id)
        { response in
            switch(response.result)
            {
            case .success(_):
                RappleActivityIndicatorView.stopAnimation()
                if let _JSON = response.data
                {
                    if let json = try! JSONSerialization.jsonObject(with: _JSON) as? [String:Any]
                    {
                        if json["error"] as! Bool
                        {
                            if let msg = json["message"] as? String
                            {
                                self.present(ActionHandler.showAlertPopViewController(message: msg, vw: self), animated: true, completion: nil)
                            }
                            else
                            {
                                self.present(ActionHandler.showAlert(message: Constants.messgs.somethingWrong), animated: true, completion: nil)
                            }
                        }
                        else
                        {
                            if let dt = json["data"] as? [String:Any]
                            {
                                self.liveDeposit = LiveDeposit.fromJSON(dt)
                                
                                self.lblNameWatch.text = self.liveDeposit.make + " " + self.liveDeposit.model
                                self.lblSerialNo.text = self.liveDeposit.serialNo
                                self.lblModel.text = self.liveDeposit.model
                                self.lblMatirial.text = self.liveDeposit.material
                                self.lblUkWatchNo.text = ""
                                self.lblYear.text = self.liveDeposit.year
                                self.lblSize.text = self.liveDeposit.size
                                self.lblDail.text = self.liveDeposit.dial
                                self.lblClientName.text = self.liveDeposit.clientName
                                self.lblEmail.text = self.liveDeposit.clientEmail
                                self.lblContactNumbe.text = self.liveDeposit.clientContactNo
                                self.lblPrice.text = "£"+self.liveDeposit.totalPrice
                                self.lblAdvPrice.text = "£"+self.liveDeposit.advancePayment
                                self.imgWatch.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "placeholder"))
                                self.txtRemainingPrice.text = ""
                                self.txtCash.text = ""
                                self.txtCard.text = ""
                                self.txtWire.text = ""
                                self.txtCrypto.text = ""
                                self.vwSellLiveOrder.isHidden = false
                                self.view.bringSubviewToFront(self.vwSellLiveOrder)
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
    
    private func sellLiveDepositOrder()
    {
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
        let parameter = ["LiveDepositID":self.liveDeposit.liveDepositID,"RemainingPayment":self.txtRemainingPrice.text!, "Card":self.txtCard.text!,"Cash":self.txtCash.text!,"Crypto":self.txtCrypto.text!, "Wire":self.txtWire.text!]
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 100
        configuration.timeoutIntervalForResource = 100
        
        alamoFireManager = Alamofire.Session(configuration: configuration)
        alamoFireManager!.upload(multipartFormData: { multipartFormData in
            
//            let proofID = self.imgSelectProofID.jpegData(compressionQuality: 0.3)!
//            multipartFormData.append(proofID, withName: "ImgProofId",fileName: "ImgProofId.jpg", mimeType: "image/jpg")
//
//            let proofAddress = self.imgSelectProofAddress.jpegData(compressionQuality: 0.3)!
//            multipartFormData.append(proofAddress, withName: "ImgProofAddress",fileName: "ImgProofAddress.jpg", mimeType: "image/jpg")
            
            if self.imgSelectedCard != nil
            {
                let imgCard = self.imgSelectedCard.jpegData(compressionQuality: 0.3)!
                multipartFormData.append(imgCard, withName: "ImgCard",fileName: "ImgCard.jpg", mimeType: "image/jpg")
            }
            if self.imgSelectedWire != nil
            {
                let imgWire = self.imgSelectedWire.jpegData(compressionQuality: 0.3)!
                multipartFormData.append(imgWire, withName: "ImgWire",fileName: "ImgWire.jpg", mimeType: "image/jpg")
            }
            if self.imgSelectedCrypto != nil
            {
                let imgCrypto = self.imgSelectedCrypto.jpegData(compressionQuality: 0.3)!
                multipartFormData.append(imgCrypto, withName: "ImgCrypto",fileName: "ImgCrypto.jpg", mimeType: "image/jpg")
            }
            
            for (key, value) in parameter {
                multipartFormData.append(((value).data(using: String.Encoding.utf8)!), withName: key)
            }
        },
                                 to: Constants.Server.baseUrl+"/JewelleryApi/SellLiveDeposit", usingThreshold: UInt64.init(), method: .post, headers: [:]).responseJSON{(response) in
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
                                self.vwSellLiveOrder.isHidden = true
                                self.present(ActionHandler.showAlert(message: msg), animated: true, completion: nil)
                                self.getAllOrder(sort: self.sort)
                                self.txtRemainingPrice.text = ""
                                self.txtCash.text = ""
                                self.txtCard.text = ""
                                self.txtWire.text = ""
                                self.txtCrypto.text = ""
                                self.imgWire.image = UIImage(named: "Sample_image")
                                self.imgCard.image = UIImage(named: "Sample_image")
                                self.imgCrypto.image = UIImage(named: "Sample_image")
                                self.imgSelectedWire = nil
                                self.imgSelectedCard = nil
                                self.imgSelectedCrypto = nil
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
}
extension LiveDepositeVC:UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if string == ""
        {
            // User presses backspace
            textField.deleteBackward()
        } else {
            // User presses a key or pastes
            if self.txtRemainingPrice == textField || textField == self.txtCash || textField == self.txtCard || textField == self.txtWire || self.txtCrypto == textField
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
extension LiveDepositeVC:CropViewControllerDelegate
{
    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
        //self.imgWatch = image
        print("Croping cancelled \(cancelled)")
        cropViewController.dismiss(animated: true, completion: nil)
    }
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int)
    {
        switch self.selectingImgType
        {
        case 1:
            self.imgSelectedCard = image
            self.imgCard.image = image
            break
        case 2:
            self.imgSelectedWire = image
            self.imgWire.image = image
            break
        case 3:
            self.imgSelectedCrypto = image
            self.imgCrypto.image = image
            break
        default:
            break
        }
        self.selectingImgType = -1
        cropViewController.dismiss(animated: true, completion: nil)
    }
}
extension LiveDepositeVC //delete api
{
    private func cancelLiveOrder(orderID:String)
    {
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
        getCancelLiveDepositByIDSer(id: orderID, completion: { response in
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
                            self.present(ActionHandler.showAlert(message: "Item has been successfully cancelled"), animated: true, completion: nil)
                            self.getAllOrder(sort: self.sort)
                        }
                    }
                }
                break
            case .failure(_):
                RappleActivityIndicatorView.stopAnimation()
                self.present(ActionHandler.showAlert(message: Constants.messgs.somethingWrong), animated: true, completion: nil)
                break
            }
        })
    }
}
