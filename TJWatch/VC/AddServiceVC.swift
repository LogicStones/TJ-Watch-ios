//
//  AddServiceVC.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 30/12/2021.
//

import UIKit
import iOSDropDown
import RappleProgressHUD
import Alamofire
import SideMenu
import CropViewController

protocol serviceEditProtocol
{
    func editDone()
}

class AddServiceVC: UIViewController, UIImagePickerControllerDelegate & UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtContactNumbet: UITextField!
    @IBOutlet weak var btnWatchImage: UIButton!
    @IBOutlet weak var vwWatchImage: UIView!
    @IBOutlet weak var imgWatch: UIImageView!
    @IBOutlet weak var txtWatchIssue: UITextView!
    @IBOutlet weak var ddlMake: DropDown!
    @IBOutlet weak var txtModel: UITextField!
    @IBOutlet weak var txtReturnDate: UITextField!
    @IBOutlet weak var txtSerialNo: UITextField!
    @IBOutlet weak var txtTotalCharges: UITextField!
    @IBOutlet weak var txtAdvance: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var vwDatePick: UIView!
    @IBOutlet weak var dtPickr: UIDatePicker!
    @IBOutlet weak var btnDoneDate: UIButton!
    @IBOutlet weak var btnCancelDate: UIButton!
    @IBOutlet weak var vwServiceCharges: UIView!
    @IBOutlet weak var vwAdvacne: UIView!
    @IBOutlet weak var txtProblem: UITextField!
    @IBOutlet weak var btnSearchOL: UIButton!
    
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
    
    @IBOutlet var btnEditWath: UIButton!
    @IBOutlet var btnMenu: UIButton!
    @IBOutlet var btnBack: UIButton!
    
    @IBOutlet weak var constrainMainContantHeight: NSLayoutConstraint!
    @IBOutlet weak var constrainTopWatchIssue: NSLayoutConstraint!
    
    var imgWatchSelected:UIImage!
    var imgReceipt:UIImage!
    var selectedMakeID = ""
    var selectedPaymentMetho = "" //Cash //Bank
    var imagePicker: UIImagePickerController!
    var alamoFireManager : Session?
    var selectingImgType = -1
    var clientID = "-1"
    var imgSelectedCard:UIImage!
    var imgSelectedWire:UIImage!
    var imgSelectedCrypto:UIImage!
    var serviceID = "0"
    var arrName:[String] = []
    var arrID:[Int] = []
    var editData:ServiceList!
    var delegate:serviceEditProtocol!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.imagePicker = UIImagePickerController()
        self.txtEmail.setBrdBg()
        self.txtEmail.delegate = self
        self.txtName.setBrdBg()
        self.txtName.delegate = self
        self.txtContactNumbet.setBrdBg()
        self.txtContactNumbet.delegate = self
        self.txtWatchIssue.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 8)
        self.txtWatchIssue.delegate = self
        self.txtModel.setBrdBg()
        self.txtModel.delegate = self
        self.txtReturnDate.setBrdBg()
        self.txtReturnDate.delegate = self
        self.txtSerialNo.setBrdBg()
        self.txtSerialNo.delegate = self
        self.txtProblem.setBrdBg()
        self.txtProblem.delegate = self
        self.txtAdvance.delegate = self
        self.txtTotalCharges.delegate = self
        self.txtCash.delegate = self
        self.txtCard.delegate = self
        self.txtWire.delegate = self
        self.txtCrypto.delegate = self
        self.btnWatchImage.vwCornerRadius(radius: 18)
        self.btnSearchOL.vwCornerRadius(radius: 18)
        self.btnSubmit.vwCornerRadius(radius: 22)
        self.btnDoneDate.vwBorderRadius(color: UIColor(red: 18/255, green: 78/255, blue: 68/255, alpha: 1.0), bordrWidth: 1, radius: 12)
        self.btnCancelDate.vwBorderRadius(color: UIColor(red: 18/255, green: 78/255, blue: 68/255, alpha: 1.0), bordrWidth: 1, radius: 12)
        self.btnDoneDate.addTarget(self, action: #selector(self.doneDate), for: .touchUpInside)
        self.dtPickr.date = Date()
        self.dtPickr.minimumDate = Date()
        self.vwServiceCharges.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 20)
        self.vwAdvacne.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 20)
        self.ddlMake.didSelect { selectedText, index, id in
            self.ddlMake.selectedIndex = id
            self.selectedMakeID = "\(id)"
        }
        self.btnWatchImage.tag = 1
        self.btnWatchImage.addTarget(self, action: #selector(self.openCamera), for: .touchUpInside)
        self.btnSubmit.addTarget(self, action: #selector(self.SubmitService), for: .touchUpInside)
        self.btnDoneDate.addTarget(self, action: #selector(self.doneDate), for: .touchUpInside)
        self.btnCancelDate.addTarget(self, action: #selector(self.cancelDate), for: .touchUpInside)
        
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
        
        self.btnEditWath.tag = 1
        self.btnEditWath.addTarget(self, action: #selector(self.editWatchImages(sndr:)), for: .touchUpInside)
        
        if self.serviceID != "0"
        {
            self.getServiceByID()
            self.btnMenu.isHidden = true
            self.btnBack.isHidden = false
            self.btnBack.addTarget(self, action: #selector(backview), for: .touchUpInside)
        }
        else
        {
            self.btnMenu.isHidden = false
            self.btnBack.isHidden = true
        }
        self.constrainMainContantHeight.constant = 1520
        
    }
    
    @objc private func backview()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func doneDate()
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        self.txtReturnDate.text = formatter.string(from: self.dtPickr.date)
        self.vwDatePick.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getMakeLst()
    }
    
    @IBAction func btnMenu(_ sender: Any) {
        let menu = storyboard!.instantiateViewController(withIdentifier: "sidemenu") as! SideMenuNavigationController
        menu.transitioningDelegate = self
        present(menu, animated: true, completion: nil)
    }
    
    @objc private func cancelDate()
    {
        self.vwDatePick.isHidden = true
    }
    
    @IBAction func btnReturnDate(_ sender: Any)
    {
        UIView.animate(withDuration: 2) {
            self.view.bringSubviewToFront(self.vwDatePick)
            self.vwDatePick.isHidden = false
        }
    }
    
    @IBAction func btnRemoveWatchImg(_ sender: Any)
    {
        self.vwWatchImage.isHidden = true
        self.constrainTopWatchIssue.constant = 15
        self.imgWatchSelected = nil
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
            let currntHeight = self.constrainMainContantHeight.constant
            switch self.selectingImgType
            {
            case 1:
                self.imgWatchSelected = selectedImage
                self.imgWatch.image = selectedImage
                self.vwWatchImage.isHidden = false
                self.constrainTopWatchIssue.constant = 80
                self.constrainMainContantHeight.constant = currntHeight + 80
                break
            case 2:
                self.imgReceipt = selectedImage
                self.constrainMainContantHeight.constant = currntHeight + 80
                break
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
            //            if self.selectingImgType == 1
            //            {
            //                let cropview = CropViewController(image: selectedImage)
            //                cropview.delegate = self
            //                self.present(cropview, animated: false, completion: nil)
            //            }
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
    
    @IBAction func btnSearchCustomer(_ sender: Any)
    {
        let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomerVC") as! CustomerVC
        vw.modalPresentationStyle = .overFullScreen
        vw.delegateCustomer = self
        self.present(vw, animated: true, completion: nil)
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
    
    @IBAction func btnNotifications(_ sender: Any) {
        let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vw, animated: true)
    }
    
    @objc private func editWatchImages(sndr:UIButton)
    {
        self.selectingImgType = sndr.tag
        var selectedImage:UIImage!
        switch sndr.tag
        {
        case 1:
            selectedImage = self.imgWatchSelected
            break
        default:
            break
        }
        self.cropImageUsingCroper(selectedImage: selectedImage)
    }
}
extension AddServiceVC:customerSearch
{
    func searchedClient(searched: Customer)
    {
        self.txtEmail.text = searched.email
        self.clientID = searched.id
        self.txtContactNumbet.text = searched.phone
        self.txtName.text = searched.name
        //        self.txtEmail.isUserInteractionEnabled = false
        //        self.txtContactNumbet.isUserInteractionEnabled = false
        //        self.txtName.isUserInteractionEnabled = false
    }
    
    func closeSearchClient()
    {
        self.txtEmail.text = ""
        self.txtContactNumbet.text = ""
        self.txtName.text = ""
        //        self.txtEmail.isUserInteractionEnabled = true
        //        self.txtContactNumbet.isUserInteractionEnabled = true
        //        self.txtName.isUserInteractionEnabled = true
    }
    
}
extension AddServiceVC:UITextViewDelegate //desicription
{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "NOTES"
        {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text == "NOTES" || textView.text == "" {
            
            textView.text = "NOTES"
            textView.textColor = UIColor.lightGray
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == ""
        {
            // User presses backspace
            textView.deleteBackward()
        } else {
            // User presses a key or pastes
            textView.insertText(text.uppercased())
        }
        // Do not let specified text range to be changed
        return false
    }
}
extension AddServiceVC //get make watch
{
    private func getMakeLst()
    {
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
        getMakeListSer { response in
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
                            if let dt = json["data"] as? [[String:Any]]
                            {
                                for mk in dt
                                {
                                    let make = WatchMake.fromJSON(mk)
                                    self.arrName.append(make.name)
                                    self.arrID.append(Int(make.id)!)
                                }
                                self.ddlMake.optionIds = self.arrID
                                self.ddlMake.optionArray = self.arrName
                                if self.editData != nil && self.serviceID != "0"
                                {
                                    let indx = self.arrID.first(where: {$0 == Int(self.editData.makeID)})
                                    self.ddlMake.selectedIndex = indx
                                    self.selectedMakeID = self.editData.makeID
                                    self.ddlMake.text = self.arrName[indx!]
                                }
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
extension AddServiceVC //submit api
{
    private func validate() -> Bool
    {
        var result = true
        //        if self.txtEmail.text == ""
        //        {
        //            self.present(ActionHandler.showAlert(message: "Please enter email address"), animated: true, completion: nil)
        //            result = false
        //        }
        if self.txtEmail.text != "" && !ActionHandler.isValidEmail(emailText: self.txtEmail.text!)
        {
            self.present(ActionHandler.showAlert(message: "Please incorrect email address"), animated: true, completion: nil)
            result = false
        }
        else if self.txtName.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Please enter customer name"), animated: true, completion: nil)
            result = false
        }
//        else if self.txtContactNumbet.text == ""
//        {
//            self.present(ActionHandler.showAlert(message: "Please enter customer contact number"), animated: true, completion: nil)
//            result = false
//        }
        else if self.imgWatchSelected == nil
        {
            self.present(ActionHandler.showAlert(message: "Please take/choose watch image"), animated: true, completion: nil)
            result = false
        }
        else if self.txtProblem.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Please enter watch problem"), animated: true, completion: nil)
            result = false
        }
        else if self.selectedMakeID == ""
        {
            self.present(ActionHandler.showAlert(message: "Please select make"), animated: true, completion: nil)
            result = false
        }
        else if self.txtModel.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Please enter model"), animated: true, completion: nil)
            result = false
        }
        else if self.txtReturnDate.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Please select return date"), animated: true, completion: nil)
            result = false
        }
        else if self.txtSerialNo.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Please enter serial number"), animated: true, completion: nil)
            result = false
        }
        else if self.txtTotalCharges.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Please enter total charges"), animated: true, completion: nil)
            result = false
        }
        else if self.txtAdvance.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Please enter advance ammount"), animated: true, completion: nil)
            result = false
        }
        else if self.selectedPaymentMetho == "Bank" && self.imgReceipt == nil
        {
            self.present(ActionHandler.showAlert(message: "Please take/choose bank receipt image"), animated: true, completion: nil)
            result = false
        }
        if self.imgSelectedCard != nil && self.txtCard.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Please enter card payment"), animated: true, completion: nil)
            result = false
        }
        if self.txtCard.text != "" && self.imgSelectedCard == nil
        {
            self.present(ActionHandler.showAlert(message: "Please take/choose card picture"), animated: true, completion: nil)
            result = false
        }
        if self.imgSelectedWire != nil && self.txtWire.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Please enter wire payment"), animated: true, completion: nil)
            result = false
        }
        if self.txtWire.text != "" && self.imgSelectedWire == nil
        {
            self.present(ActionHandler.showAlert(message: "Please take/choose wire picture"), animated: true, completion: nil)
            result = false
        }
        if self.imgSelectedCrypto != nil && self.txtCrypto.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Please enter crypto payment"), animated: true, completion: nil)
            result = false
        }
        if self.txtCrypto.text != "" && self.imgSelectedCrypto == nil
        {
            self.present(ActionHandler.showAlert(message: "Please take/choose crypto picture"), animated: true, completion: nil)
            result = false
        }
        return result
    }
    
    @objc private func SubmitService()
    {
       
        if self.serviceID == "0" && !self.validate()
        {
            return
        }
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
        let descrp = self.txtWatchIssue.text == "NOTES" ? "" : self.txtWatchIssue.text
        let remaining = Double(self.txtTotalCharges.text!.replacingOccurrences(of: ",", with: ""))! - Double(self.txtAdvance.text!.replacingOccurrences(of: ",", with: ""))!
        let parameter = ["UserID":SharedManager.sharedInstance.userData.id, "CustEmail":self.txtEmail.text!,"CustName":self.txtName.text!, "CustContactNo":self.txtContactNumbet.text!,"Notes":descrp,"MakeID":self.selectedMakeID, "Model":self.txtModel.text!,"ReturnDT":self.txtReturnDate.text!, "TotalCost":self.txtTotalCharges.text!, "TypeOfProblem":self.txtProblem.text!,"ServiceID":self.serviceID,"SerialNo":self.txtSerialNo.text!,"Advance":self.txtAdvance.text!,"AdvancePayType":self.selectedPaymentMetho,"RemainingPayment":"\(remaining)", "ClientID":self.clientID, "Card":self.txtCard.text!, "Cash":self.txtCash.text!, "Crypto":self.txtCrypto.text!, "Wire":self.txtWire.text!]
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 100
        configuration.timeoutIntervalForResource = 100
        
        alamoFireManager = Alamofire.Session(configuration: configuration)
        alamoFireManager!.upload(multipartFormData: { multipartFormData in
            
            if self.imgWatchSelected != nil
            {
                let mugImgData = self.imgWatchSelected.jpegData(compressionQuality: 0.2)!
                multipartFormData.append(mugImgData, withName: "ImgWatch",fileName: "ImgWatch.jpg", mimeType: "image/jpg")
            }
            
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
                multipartFormData.append(((value)!.data(using: String.Encoding.utf8)!), withName: key)
            }
        },
                                 to: Constants.Server.baseUrl+"/JewelleryApi/InsertUpdateService", usingThreshold: UInt64.init(), method: .post, headers: [:]).responseJSON{(response) in
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
                                self.clearFields()
                                let alert = UIAlertController(title: "Alert!", message: msg, preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { UIAlertAction in
                                    if self.serviceID == "0"
                                    {
                                        let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ServiceListVC") as! ServiceListVC
                                        
                                        self.navigationController?.pushViewController(vw, animated: true)
                                    }
                                    else
                                    {
                                        self.delegate.editDone()
                                        self.dismiss(animated: true, completion: nil)
                                    }
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
    
    private func clearFields()
    {
        self.txtEmail.text = ""
        self.txtName.text = ""
        self.txtContactNumbet.text = ""
        self.vwWatchImage.isHidden = true
        self.imgWatchSelected = nil
        self.constrainTopWatchIssue.constant = 15
        self.txtProblem.text = ""
        self.txtWatchIssue.text = "NOTES"
        self.ddlMake.text = ""
        self.selectedMakeID = ""
        self.txtModel.text = ""
        self.txtReturnDate.text = ""
        self.txtSerialNo.text = ""
        self.txtTotalCharges.text = ""
        self.txtAdvance.text = ""
        self.constrainMainContantHeight.constant = 1520
        self.clientID = "-1"
        self.txtEmail.isUserInteractionEnabled = true
        self.txtName.isUserInteractionEnabled = true
        self.txtContactNumbet.isUserInteractionEnabled = true
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
    }
}

extension AddServiceVC:UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if string == ""
        {
            // User presses backspace
            textField.deleteBackward()
        } else {
            // User presses a key or pastes
            if self.txtAdvance == textField || textField == self.txtCash || textField == self.txtCard || textField == self.txtWire || self.txtCrypto == textField || textField == self.txtTotalCharges
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
extension AddServiceVC:CropViewControllerDelegate
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
            self.imgWatchSelected = image
            self.imgWatch.image = image
            break
        case 2:
            self.imgReceipt = image
            break
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
        cropViewController.dismiss(animated: true, completion: nil)
    }
}
extension AddServiceVC
{
    private func getServiceByID()
    {
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
        getServiceDetailByIDSer(Id: self.serviceID) { response in
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
                                let srvc = ServiceList.fromJSON(dt)
                                self.editData = srvc
                                self.txtEmail.text = srvc.email
                                self.txtName.text = srvc.custName
                                self.txtContactNumbet.text = srvc.contactNo
                                self.clientID = srvc.clientId
                                self.txtProblem.text = srvc.typeOfProblem
                                self.txtWatchIssue.text = srvc.descrption
                                self.txtWatchIssue.textColor = srvc.descrption != "" ? UIColor.black : UIColor.lightGray
                                if self.arrID.count>0
                                {
                                    let indx = self.arrID.first(where: {$0 == Int(self.editData.makeID)})
                                    self.ddlMake.selectedIndex = indx
                                    self.selectedMakeID = self.editData.makeID
                                    self.ddlMake.text = self.arrName[indx!]
                                }
                               // self.ddlMake.selectedIndex = self.arrID.first(where: {$0 == Int(srvc.makeID)})
                                self.txtModel.text = srvc.model
                                self.txtReturnDate.text = srvc.returnDT
                                self.txtSerialNo.text = srvc.serialNo
                                self.txtTotalCharges.text = srvc.serviceCharges
                                self.txtAdvance.text = srvc.advance
                                self.txtCash.text = srvc.cash
                                self.txtCard.text = srvc.card
                                self.txtWire.text = srvc.wire
                                self.txtCrypto.text = srvc.crypto
                                self.imgWatch.sd_setImage(with: URL(string: srvc.watchImg)) { img, err, SDImageCacheType, url in
                                    if img != nil
                                    {
                                        self.imgWatch.image = img
                                        self.imgWatch.isHidden = false
                                        self.vwWatchImage.isHidden = false
                                        self.imgWatchSelected = img
                                        let currntHeight = self.constrainMainContantHeight.constant
                                        self.constrainTopWatchIssue.constant = 80
                                        self.constrainMainContantHeight.constant = currntHeight + 80
                                    }
                                }
                                self.imgCard.sd_setImage(with: URL(string: srvc.imgCard)) { img, err, SDImageCacheType, url in
                                    if img != nil
                                    {
                                        self.imgCard.image = img
                                        self.imgCard.isHidden = false
                                        self.imgSelectedCard = img
                                    }
                                }
                                self.imgWire.sd_setImage(with: URL(string: srvc.imgWire)) { img, err, SDImageCacheType, url in
                                    if img != nil
                                    {
                                        self.imgWire.image = img
                                        self.imgWire.isHidden = false
                                        self.imgSelectedWire = img
                                    }
                                }
                                self.imgCrypto.sd_setImage(with: URL(string: srvc.imgCrypto)) { img, err, SDImageCacheType, url in
                                    if img != nil
                                    {
                                        self.imgCrypto.image = img
                                        self.imgCrypto.isHidden = false
                                        self.imgSelectedCrypto = img
                                    }
                                }
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
