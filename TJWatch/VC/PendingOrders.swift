//
//  PendingOrders.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 26/01/2022.
//

import UIKit
import RappleProgressHUD
import Alamofire
import SDWebImage
import CropViewController

protocol AddWatchDelegate
{
    func addWatch(watch:PendingOrdersModel)
    func cancelAddWatch()
}

class PendingOrders: UIViewController, UIImagePickerControllerDelegate, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var imgNoData: UIImageView!
    @IBOutlet weak var vwEmpty: UIView!
    @IBOutlet weak var tblPendingOrders: UITableView!
    @IBOutlet weak var lblHeadiing: UILabel!
    
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
    
    @IBOutlet weak var vwSellPendingOrder: UIView!
    @IBOutlet weak var vwSellPendingOrderContant: UIView!
    
    var sort = "asc"
    var arrPendingOrder:[PendingOrdersModel] = []
    var isFromBuy = false
    var delegate:AddWatchDelegate!
    var imagePicker: UIImagePickerController!
    var alamoFireManager : Session?
    var selectingImgType = -1
    var imgSelectedCard:UIImage!
    var imgSelectedWire:UIImage!
    var imgSelectedCrypto:UIImage!
    var pendingOrder:PendingOrdersModel!
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.imagePicker = UIImagePickerController()
        if self.isFromBuy
        {
            self.lblHeadiing.text = "Add Watch"
        }
        else
        {
            self.lblHeadiing.text = "Pending Orders"
        }
        self.imgNoData.setImgTintColor(colr: UIColor.lightGray)
        self.tblPendingOrders.delegate = self
        self.tblPendingOrders.dataSource = self
        self.btnSellOrder.vwCornerRadius(radius: 20)
        self.vwSellPendingOrderContant.vwCornerRadius(radius: 12)
        
        self.btnSellOrder.addTarget(self, action: #selector(self.sellOrder(sndr:)), for: .touchUpInside)
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
        self.getPendingLst()
        self.txtCash.delegate = self
        self.txtCard.delegate = self
        self.txtWire.delegate = self
        self.txtCrypto.delegate = self
        self.txtRemainingPrice.delegate = self
        self.refreshControl.tintColor = Constants.appColors.green
        self.refreshControl.addTarget(self, action: #selector(self.refereshData), for: .valueChanged)
        self.tblPendingOrders.addSubview(refreshControl)
        self.tblPendingOrders.alwaysBounceVertical = true
    }
    
    @objc private func refereshData()
    {
        self.getPendingLst()
    }
    
    @IBAction func btnBack(_ sender: Any)
    {
        if self.delegate == nil
        {
            self.navigationController?.popViewController(animated: true)
        }
        else
        {
            self.delegate.cancelAddWatch()
            self.navigationController?.popViewController(animated: true)
        }
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
        self.getPendingLst()
    }
    
    @IBAction func btnClosePendingOrder(_ sender: Any)
    {
        self.vwSellPendingOrder.isHidden = true
    }
    
    
    @objc private func sellOrder(sndr:UIButton)
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
        self.sellPendigOrder()
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
            //self.selectingImgType = -1
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
extension PendingOrders:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrPendingOrder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblPendingOrders.dequeueReusableCell(withIdentifier: "PendingOrderCell", for: indexPath) as! PendingOrderCell
        let order = self.arrPendingOrder[indexPath.row]
        cell.lblName.text = order.clientName
        cell.lblMake.text = order.make
        cell.lblModel.text = order.model
        cell.lblYear.text = order.year
        cell.lblPrice.text = order.price
        cell.lblAdvPrice.text = order.advPayment
        cell.lblBalance.text = ActionHandler.addComma(amount: "\(Int(order.price.replacingOccurrences(of: ",", with: ""))! - Int(order.advPayment.replacingOccurrences(of: ",", with: ""))!)")
        cell.lblDail.text = order.dial
        if self.isFromBuy
        {
            cell.btnSell.isHidden = true
            cell.btnAddWatch.isHidden = false
            cell.btnDel.isHidden = true
        }
        else
        {
            cell.btnSell.isHidden = false
            cell.btnAddWatch.isHidden = true
            cell.btnDel.isHidden = false
            if order.purchaseId == ""
            {
                cell.btnSell.isHidden = true
            }
            else
            {
                cell.btnSell.isHidden = false
            }
        }
        cell.btnSell.tag = indexPath.row + 100
        cell.btnSell.addTarget(self, action: #selector(self.sellNow(sndr:)), for: .touchUpInside)
        cell.btnAddWatch.tag = indexPath.row + 200
        cell.btnAddWatch.addTarget(self, action: #selector(self.addWatch(sndr:)), for: .touchUpInside)
        cell.btnDel.tag = indexPath.row + 300
        cell.btnDel.addTarget(self, action: #selector(self.cancelOrder(sndr:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let ordr = self.arrPendingOrder[indexPath.row]
        if self.isFromBuy
        {
            return 200
        }
        else
        {
            if ordr.purchaseId != ""
            {
                return 200
            }
            else
            {
                return 145
            }
        }
    }
    
    @objc private func sellNow(sndr:UIButton)
    {
        let ordr = self.arrPendingOrder[sndr.tag - 100]
        self.getOrderByID(id: ordr.id)
    }
    
    @objc private func addWatch(sndr:UIButton)
    {
        let ordr = self.arrPendingOrder[sndr.tag - 200]
        self.delegate.addWatch(watch: ordr)
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc private func cancelOrder(sndr:UIButton)
    {
        let ordr = self.arrPendingOrder[sndr.tag - 300]
        let alert = UIAlertController(title: "Alert!", message: "Are you sure you want to cancel this item?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { UIAlertAction in
            self.cancelPendingOrder(orderID: ordr.id)
        }))
        alert.addAction(UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel, handler: { UIAlertAction in
        }))
        alert.view.tintColor = UIColor.black
        self.present(alert, animated: true, completion: nil)
    }
    
}
extension PendingOrders //api
{
    private func getPendingLst()
    {
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
        getPendingOrdersSer(sort: self.sort) { response in
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
                                self.arrPendingOrder = []
                                for mk in dt
                                {
                                    let ordr = PendingOrdersModel.fromJSON(mk)
                                    self.arrPendingOrder.append(ordr)
                                }
                                if self.arrPendingOrder.count == 0
                                {
                                    self.vwEmpty.isHidden = false
                                    self.tblPendingOrders.isHidden = true
                                }
                                else
                                {
                                    self.vwEmpty.isHidden = true
                                    self.tblPendingOrders.isHidden = false
                                }
                                self.tblPendingOrders.reloadData()
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
extension PendingOrders //api
{
    private func sellPendigOrder()
    {
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
        let parameter = ["PendingOrderId":self.pendingOrder.pendingOrderID, "RemainingPayment":self.txtRemainingPrice.text!, "Card":self.txtCard.text!,"Cash":self.txtCash.text!,"Crypto":self.txtCrypto.text!, "Wire":self.txtWire.text!]
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 100
        configuration.timeoutIntervalForResource = 100
        
        alamoFireManager = Alamofire.Session(configuration: configuration)
        alamoFireManager!.upload(multipartFormData: { multipartFormData in
            
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
                                 to: Constants.Server.baseUrl+"/JewelleryApi/SellPedningOrder", usingThreshold: UInt64.init(), method: .post, headers: [:]).responseJSON{(response) in
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
                                // self.fieldDataRemove()
                                // self.present(ActionHandler.showAlert(message: msg), animated: true, completion: nil)
                                let alert = UIAlertController(title: "Alert!", message: msg, preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { UIAlertAction in
                                    self.tabBarController?.selectedIndex = 1
                                }))
                                alert.view.tintColor = UIColor.black
                                self.present(alert, animated: true, completion: nil)
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
    
    private func getOrderByID(id:String)
    {
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
        getPendingOrderByIDSer(id: id) { response in
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
                                //  self.present(ActionHandler.showAlert(message: msg), animated: true, completion: nil)
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
                                let pdngOrdr = PendingOrdersModel.fromJSON(dt)
                                self.pendingOrder = pdngOrdr
                                
                                self.lblNameWatch.text = self.pendingOrder.make + " " + self.pendingOrder.model
                                self.lblSerialNo.text = self.pendingOrder.serialNo
                                self.lblModel.text = self.pendingOrder.model
                                self.lblMatirial.text = self.pendingOrder.material
                                self.lblUkWatchNo.text = ""
                                self.lblYear.text = self.pendingOrder.year
                                self.lblSize.text = self.pendingOrder.size
                                self.lblDail.text = self.pendingOrder.dial
                                self.lblClientName.text = self.pendingOrder.clientName
                                self.lblEmail.text = self.pendingOrder.clientEmail
                                self.lblContactNumbe.text = self.pendingOrder.clientContactNo
                                self.lblPrice.text = self.pendingOrder.totalPrice
                                self.lblAdvPrice.text = self.pendingOrder.advancePayment
                                self.imgWatch.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "placeholder"))
                                self.vwSellPendingOrder.isHidden = false
                                self.view.bringSubviewToFront(self.vwSellPendingOrder)
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
extension PendingOrders:UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if string == ""
        {
            // User presses backspace
            textField.deleteBackward()
        } else {
            // User presses a key or pastes
            if textField == self.txtCash || textField == self.txtCard || textField == self.txtWire || self.txtCrypto == textField || self.txtRemainingPrice == textField
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
extension PendingOrders:CropViewControllerDelegate
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
extension PendingOrders //delete api
{
    private func cancelPendingOrder(orderID:String)
    {
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
        getCancelPendingOrderIDSer(id: orderID, completion: { response in
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
                            self.getPendingLst()
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
