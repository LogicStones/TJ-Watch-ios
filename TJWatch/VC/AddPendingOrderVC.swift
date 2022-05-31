//
//  AddPendingOrderVC.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 24/01/2022.
//

import UIKit
import Alamofire
import iOSDropDown
import RappleProgressHUD
import CropViewController

 
class AddPendingOrderVC: UIViewController, UIImagePickerControllerDelegate, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSellerName: UITextField!
    @IBOutlet weak var txtContactNumber: UITextField!
    @IBOutlet weak var btnProofID: UIButton!
    
    @IBOutlet weak var btnTakeAddressID: UIButton!
    @IBOutlet weak var ddlMake: DropDown!
    @IBOutlet weak var txtModel: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var vwPrice: UIView!
    @IBOutlet weak var vwAdvancePrice: UIView!
    @IBOutlet weak var txtAdvancePrice: UITextField!
    @IBOutlet weak var vwRemainingPricw: UIView!
    @IBOutlet weak var txtRemainingPrice: UITextField!
    @IBOutlet weak var txtWatchYear: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var vwProofID: UIView!
    @IBOutlet weak var imgProof: UIImageView!
    @IBOutlet weak var vwProofAddress: UIView!
    @IBOutlet weak var imgProofAddress: UIImageView!
    @IBOutlet weak var btnSearchSellerOL: UIButton!
    
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
    @IBOutlet var txtDail: UITextField!
    
    
    
    @IBOutlet weak var constrainMainContantHeight: NSLayoutConstraint! //1550
    @IBOutlet weak var constrainMakeTop: NSLayoutConstraint! //15 //80
    @IBOutlet weak var constrainProofAdressTop: NSLayoutConstraint! //15 //80
    
    var selectedMakeID = -1
    var imgProofID:UIImage!
    var imgAddress:UIImage!
    var imagePicker: UIImagePickerController!
    var alamoFireManager : Session?
    var clientID = "-1"
    var selectingImgType = -1
    var imgSelectedCard:UIImage!
    var imgSelectedWire:UIImage!
    var imgSelectedCrypto:UIImage!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.imagePicker = UIImagePickerController()
        self.txtEmail.setBrdBg()
        self.txtEmail.delegate = self
        self.txtSellerName.setBrdBg()
        self.txtSellerName.delegate = self
        self.txtContactNumber.setBrdBg()
        self.txtContactNumber.delegate = self
        self.ddlMake.setBrdBg()
        self.txtModel.setBrdBg()
        self.txtDail.setBrdBg()
        self.txtDail.delegate = self
        self.txtModel.delegate = self
        self.txtWatchYear.setBrdBg()
        self.txtWatchYear.delegate = self
        self.txtDescription.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 8)
        self.txtDescription.delegate = self
        self.txtCash.delegate = self
        self.txtCard.delegate = self
        self.txtWire.delegate = self
        self.txtCrypto.delegate = self
        self.txtPrice.delegate = self
        self.txtAdvancePrice.delegate = self
        self.btnProofID.vwCornerRadius(radius: 20)
        self.btnTakeAddressID.vwCornerRadius(radius: 20)
        self.btnSearchSellerOL.vwCornerRadius(radius: 18)
        self.btnSubmit.vwCornerRadius(radius: 22)
        self.vwPrice.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 22)
        self.vwAdvancePrice.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 22)
        self.vwRemainingPricw.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 22)
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
        
        self.txtAdvancePrice.addTarget(self, action: #selector(self.calculateRemainingPrice), for: .editingChanged)
       self.txtPrice.addTarget(self, action: #selector(self.calculateRemainingPrice), for: .editingChanged)
        
        self.btnProofID.addTarget(self, action: #selector(self.openCamera(snder:)), for: .touchUpInside)
        self.btnTakeAddressID.addTarget(self, action: #selector(self.openCamera(snder:)), for: .touchUpInside)
        self.btnSubmit.addTarget(self, action: #selector(self.submitSell), for: .touchUpInside)
        self.btnProofID.tag = 1
        self.btnTakeAddressID.tag = 2
        
        self.ddlMake.didSelect
        { selectedText, index, id in
            self.ddlMake.selectedIndex = id
            self.selectedMakeID = id
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.getMakeLst()
    }
    
    @IBAction func txtPriceChanged(_ sender: Any)
    {
        //self.calculateRemainingPrice()
    }
//    @IBAction func txtAdvancePriceChanged(_ sender: Any)
//    {
//
//    }
//
//    @IBAction func advcnValue(_ sender: Any) {
//        self.calculateRemainingPrice()
//    }
//
//    @IBAction func primaryAct(_ sender: Any, forEvent event: UIEvent)
//    {
//        print("primary")
//    }
    @objc private func calculateRemainingPrice()
    {
        let pr =  String(format: "%.2f", Double(self.txtPrice.text != "" ? self.txtPrice.text!.replacingOccurrences(of: ",", with: "") : "0.0")! - Double(self.txtAdvancePrice.text == "" ? "0.0" : self.txtAdvancePrice.text!.replacingOccurrences(of: ",", with: ""))!)
        self.txtRemainingPrice.text = pr
    }
    
    @IBAction func btnBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
}
extension AddPendingOrderVC:customerSearch
{
    func searchedClient(searched: Customer)
    {
        let currntHeight = self.constrainMainContantHeight.constant
        self.clientID = searched.id
        self.txtEmail.text = searched.email
        self.txtContactNumber.text = searched.phone
        self.txtSellerName.text = searched.name
       // self.txtEmail.isUserInteractionEnabled = false
       // self.txtContactNumber.isUserInteractionEnabled = false
      //  self.txtSellerName.isUserInteractionEnabled = false
        self.imgProof.sd_setImage(with: URL(string: searched.proofIdImg), placeholderImage: UIImage(named: "placeholder"))
        self.imgProofID = self.imgProof.image
        self.constrainProofAdressTop.constant = 80
        // self.constrainMainContantHeight.constant = currntHeight + 80
        self.imgProofAddress.sd_setImage(with: URL(string: searched.proofAddressImg), placeholderImage: UIImage(named: "placeholder"))
        self.imgAddress = self.imgProofAddress.image
        // currntHeight = self.constrainMainContantHeight.constant
        self.constrainMainContantHeight.constant = currntHeight + 190
        self.constrainMakeTop.constant = 80
        self.vwProofAddress.isHidden = false
        self.vwProofID.isHidden = false
    }
    
    func closeSearchClient()
    {
        self.txtEmail.text = ""
        self.txtContactNumber.text = ""
        self.txtSellerName.text = ""
       // self.txtEmail.isUserInteractionEnabled = true
       // self.txtContactNumber.isUserInteractionEnabled = true
      //  self.txtSellerName.isUserInteractionEnabled = true
        self.imgProofID = nil
        self.vwProofID.isHidden = true
        self.constrainProofAdressTop.constant = 15
        self.imgAddress = nil
        self.constrainMakeTop.constant = 15
        self.vwProofAddress.isHidden = true
        self.clientID = "-1"
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
    
    @objc private func choosePic(snder:UIButton)
    {
        self.selectingImgType = snder.tag
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum)
        {
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc private func submitSell()
    {
        if self.txtSellerName.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Please enter client name"), animated: true, completion: nil)
            return
        }
//        if self.txtEmail.text == ""
//        {
//            self.present(ActionHandler.showAlert(message: "Please enter email address"), animated: true, completion: nil)
//            return
//        }
        if self.txtEmail.text != "" && !ActionHandler.isValidEmail(emailText: self.txtEmail.text!)
        {
            self.present(ActionHandler.showAlert(message: "Please enter correct email address"), animated: true, completion: nil)
            return
        }
//        if self.txtContactNumber.text == ""
//        {
//            self.present(ActionHandler.showAlert(message: "Please enter contact number"), animated: true, completion: nil)
//            return
//        }
//        if imgProofID == nil
//        {
//            self.present(ActionHandler.showAlert(message: "Please take/choose proof of ID"), animated: true, completion: nil)
//            return
//        }
//        if imgAddress == nil
//        {
//            self.present(ActionHandler.showAlert(message: "Please take/choose proof of address"), animated: true, completion: nil)
//            return
//        }
        if self.selectedMakeID == -1
        {
            self.present(ActionHandler.showAlert(message: "Please select make"), animated: true, completion: nil)
            return
        }
        if self.txtModel.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Please enter model"), animated: true, completion: nil)
            return
        }
        if self.txtWatchYear.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Please enter watch year"), animated: true, completion: nil)
            return
        }
        if self.txtPrice.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Please enter price"), animated: true, completion: nil)
            return
        }
        if self.txtAdvancePrice.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Please enter advance payment"), animated: true, completion: nil)
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
        
        self.addPendigOrder()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let selectedImage =  info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            let currntHeight = self.constrainMainContantHeight.constant
            switch self.selectingImgType
            {
            case 1:
                self.imgProofID = selectedImage
                self.imgProof.image = selectedImage
                self.vwProofID.isHidden = false
                self.constrainProofAdressTop.constant = 80
                self.constrainMainContantHeight.constant = currntHeight + 80
                break
            case 2:
                self.imgAddress = selectedImage
                self.imgProofAddress.image = selectedImage
                self.vwProofAddress.isHidden = false
                self.constrainMakeTop.constant = 80
                self.constrainMainContantHeight.constant = currntHeight + 80
                break
            case 4:
                self.imgSelectedCard = selectedImage
                self.imgCard.image = selectedImage
                break
            case 5:
                self.imgSelectedWire = selectedImage
                self.imgWire.image = selectedImage
                break
            case 6:
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
    
    @IBAction func btnCloseProofImgID(_ sender: Any)
    {
        constrainProofAdressTop.constant = 15
        let currntHeight = self.constrainMainContantHeight.constant
        self.constrainMainContantHeight.constant = currntHeight - 80
        self.vwProofID.isHidden = true
        self.imgProofID = nil
    }
    
    @IBAction func btnCloseAddressImg(_ sender: Any)
    {
        constrainMakeTop.constant = 15
        self.vwProofAddress.isHidden = true
        let currntHeight = self.constrainMainContantHeight.constant
        self.constrainMainContantHeight.constant = currntHeight - 80
        self.imgAddress = nil
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
        sndr.tag = 4
        self.openCamera(snder: sndr)
    }
    
    @IBAction func btnSelectWirePriceImg(_ sender: Any)
    {
        let sndr = sender as! UIButton
        sndr.tag = 5
        self.openCamera(snder: sndr)
    }
    
    @IBAction func btnSelectCryptpPriceImage(_ sender: Any)
    {
        let sndr = sender as! UIButton
        sndr.tag = 6
        self.openCamera(snder: sndr)
    }
}

extension AddPendingOrderVC:UITextViewDelegate //desicription
{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "DESCRIPTION"
        {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text == "DESCRIPTION" || textView.text == "" {
            
            textView.text = "DESCRIPTION"
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

extension AddPendingOrderVC //get make watch
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
                                var arrName:[String] = []
                                var arrID:[Int] = []
                                for mk in dt
                                {
                                    let make = WatchMake.fromJSON(mk)
                                    arrName.append(make.name)
                                    arrID.append(Int(make.id)!)
                                }
                                self.ddlMake.optionIds = arrID
                                self.ddlMake.optionArray = arrName
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

extension AddPendingOrderVC:UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
            if string == ""
            {
                // User presses backspace
                textField.deleteBackward()
            }
        else
        {
                // User presses a key or pastes
                if self.txtPrice == textField || textField == self.txtCash || textField == self.txtCard || textField == self.txtWire || self.txtCrypto == textField || textField == self.txtAdvancePrice || self.txtRemainingPrice == textField
                {
                    print("Text:: \(textField.text!)")
                    let commaStr = ActionHandler.addComma(amount: textField.text! == "" ? string : textField.text!+string)
                    print("comma Separated:: \(commaStr)")
                    textField.text = commaStr
                    self.calculateRemainingPrice()
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

extension AddPendingOrderVC //api
{
    private func addPendigOrder()
    {
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
        let descrp:String = self.txtDescription.text.lowercased() == "Description" ? "" : self.txtDescription.text
        let parameter = ["UserID":SharedManager.sharedInstance.userData.id,"MakeID":"\(self.selectedMakeID)", "WatchModel":self.txtModel.text!, "WatchYear":self.txtWatchYear.text!,"Description":descrp,"CustContactNo":self.txtContactNumber.text!,"CustEmail":self.txtEmail.text!, "ClientName":self.txtSellerName.text!,"ClientID":self.clientID, "TotalPrice":self.txtPrice.text!, "AdvancePayment":self.txtAdvancePrice.text!, "Card":self.txtCard.text!,"Cash":self.txtCash.text!, "Crypto":self.txtCrypto.text!, "Wire":self.txtWire.text!, "RemainingPayment":self.txtRemainingPrice.text!, "Dial":self.txtDail.text!]
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 100
        configuration.timeoutIntervalForResource = 100
        
        alamoFireManager = Alamofire.Session(configuration: configuration)
        alamoFireManager!.upload(multipartFormData: { multipartFormData in
            
            if self.imgProofID != nil
            {
                let mugImgData = self.imgProofID.jpegData(compressionQuality: 0.3)!
                multipartFormData.append(mugImgData, withName: "ImgProofId",fileName: "ImgProofId.jpg", mimeType: "image/jpg")
            }
            if self.imgAddress != nil
            {
                let imgAddress = self.imgAddress.jpegData(compressionQuality: 0.3)!
                multipartFormData.append(imgAddress, withName: "ImgProofAddress",fileName: "ImgProofAddress.jpg", mimeType: "image/jpg")
            }

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
                                 to: Constants.Server.baseUrl+"/JewelleryApi/AddPendingOrder", usingThreshold: UInt64.init(), method: .post, headers: [:]).responseJSON{(response) in
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
                                // self.present(ActionHandler.showAlert(message: msg), animated: true, completion: nil)
                                let alert = UIAlertController(title: "Alert!", message: msg, preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { UIAlertAction in
                                    self.tabBarController?.selectedIndex = 1
                                }))
                                alert.view.tintColor = UIColor.black
                                let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PendingOrders") as! PendingOrders
                                self.present(ActionHandler.showAlertPushViewController(message: msg, vwParent: self, moveVW: vw), animated: true)
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
        self.txtEmail.text = ""
        self.txtSellerName.text = ""
        self.txtContactNumber.text = ""
        self.imgProofID = nil
        self.vwProofID.isHidden = true
        self.constrainProofAdressTop.constant = 15
        self.imgAddress = nil
        self.vwProofAddress.isHidden = true
        self.constrainMakeTop.constant = 15
        self.constrainMakeTop.constant = 15
        self.ddlMake.text = ""
        self.selectedMakeID = -1
        self.txtPrice.text = ""
        self.txtWatchYear.text = ""
        self.constrainMainContantHeight.constant = 1550
        self.txtDescription.text = "DESCRIPTION"
        self.txtDescription.textColor = UIColor.lightGray
        self.txtModel.text = ""
        self.txtEmail.isUserInteractionEnabled = true
        self.txtSellerName.isUserInteractionEnabled = true
        self.txtContactNumber.isUserInteractionEnabled = true
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
        self.txtAdvancePrice.text = ""
        self.txtRemainingPrice.text = ""
    }
}
extension AddPendingOrderVC:CropViewControllerDelegate
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
            self.imgProofID = image
            self.imgProof.image = image
            break
        case 2:
            self.imgAddress = image
            self.imgProofAddress.image = image
            break
        case 4:
            self.imgSelectedCard = image
            self.imgCard.image = image
            break
        case 5:
            self.imgSelectedWire = image
            self.imgWire.image = image
            break
        case 6:
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
