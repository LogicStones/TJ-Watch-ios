//
//  EditWatchVC.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 12/02/2022.

protocol editWatchDelegate {
    func successEdit(productID:String)
}

import UIKit
import Alamofire
import RappleProgressHUD
import iOSDropDown
import CropViewController

class EditWatchVC: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIViewControllerTransitioningDelegate
{
    @IBOutlet weak var btnTakeWatch: UIButton!
    @IBOutlet weak var ddlMake: DropDown!
    @IBOutlet weak var txtModel: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var vwPrice: UIView!
    @IBOutlet weak var txtWatchYear: UITextField!
    @IBOutlet weak var txtSerialNo: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var vwWatchImg: UIView!
    @IBOutlet weak var imgWatchShow: UIImageView!
    
    @IBOutlet weak var txtSubModel: UITextField!
    @IBOutlet weak var txtDial: UITextField!
    @IBOutlet weak var txtSize: UITextField!
    @IBOutlet weak var txtMaterial: UITextField!
    @IBOutlet weak var txtCustomization: UITextField!
    @IBOutlet weak var btnYesBox: UIButton!
    @IBOutlet weak var btnNoBox: UIButton!
    
    @IBOutlet weak var btnYesPaperWork: UIButton!
    @IBOutlet weak var btnNoPaperWork: UIButton!
    @IBOutlet weak var btnYesServicePaper: UIButton!
    @IBOutlet weak var btnNoServicePaper: UIButton!
    
    @IBOutlet var btnCrossWatch1: UIButton!
    @IBOutlet var btnAddWatch1: UIButton!
    @IBOutlet var stckWatchImages: UIStackView!
    @IBOutlet var btnAddWatch2: UIButton!
    @IBOutlet var btnAddWatch3: UIButton!
    @IBOutlet var btnCrossWatch2: UIButton!
    @IBOutlet var btnCrossWatch3: UIButton!
    @IBOutlet var imgWatch2: UIImageView!
    @IBOutlet var imgWatch3: UIImageView!
    
    @IBOutlet var btnEditWatch1: UIButton!
    @IBOutlet var btnEditWatch2: UIButton!
    @IBOutlet var btnEditWatch3: UIButton!
    
    @IBOutlet weak var constrainMainContantHeight: NSLayoutConstraint! //2150
    @IBOutlet weak var constrainMakeTop: NSLayoutConstraint! //15 //80
    
    var selectedMakeID = -1
    var paperWork = ""
    var servicePaper = ""
    var box = ""
    var imgWatch:UIImage!
    var selectingImgType = -1
    var imagePicker: UIImagePickerController!
    var alamoFireManager : Session?
    var clientID = "-1"
    
    var arrPurchaseTypeName:[String] = ["Instock","Pending Order"]
    var arrPurchaseTypeID:[Int] = [0,1]
    var selectedPurchaseType = "1"
    var imgSelectedCard:UIImage!
    var imgSelectedWire:UIImage!
    var imgSelectedCrypto:UIImage!
    var selectedWatch:PendingOrdersModel!
    var arrPurchaseName:[String] = []
    var arrPurchaseID:[Int] = []
    var isFromMenu = true
    var productID = ""
    var productDetail:WatchData!
    var arrName:[String] = []
    var arrID:[Int] = []
    var delegate:editWatchDelegate!
    var imgSelectedWatch2:UIImage!
    var imgSelectedWatch3:UIImage!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.imagePicker = UIImagePickerController()
        self.ddlMake.setBrdBg()
        self.getMakeLst()
        self.getProductDetailByID()
        self.txtModel.setBrdBg()
        self.txtModel.delegate = self
        self.txtWatchYear.setBrdBg()
        self.txtWatchYear.delegate = self
        self.txtSerialNo.setBrdBg()
        self.txtSerialNo.delegate = self
        self.txtSubModel.setBrdBg()
        self.txtSubModel.delegate = self
        self.txtDial.setBrdBg()
        self.txtDial.delegate = self
        self.txtSize.setBrdBg()
        self.txtSize.delegate = self
        self.txtMaterial.setBrdBg()
        self.txtMaterial.delegate = self
        self.txtCustomization.setBrdBg()
        self.txtCustomization.delegate = self
        self.txtDescription.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 8)
        self.txtDescription.delegate = self
        self.btnTakeWatch.vwCornerRadius(radius: 20)
        self.btnSubmit.vwCornerRadius(radius: 22)
        self.vwPrice.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 22)
        
        self.btnTakeWatch.addTarget(self, action: #selector(self.openCamera(snder:)), for: .touchUpInside)
        self.btnSubmit.addTarget(self, action: #selector(self.submitSell), for: .touchUpInside)
        self.btnYesPaperWork.addTarget(self, action: #selector(self.yesPaperWork(sndr:)), for: .touchUpInside)
        self.btnNoPaperWork.addTarget(self, action: #selector(self.noPaperWork(sndr:)), for: .touchUpInside)
        self.btnYesServicePaper.addTarget(self, action: #selector(self.yesSerivePaper(sndr:)), for: .touchUpInside)
        self.btnNoServicePaper.addTarget(self, action: #selector(self.noSerivePaper(sndr:)), for: .touchUpInside)
        self.btnYesBox.addTarget(self, action: #selector(self.yesBox(sndr:)), for: .touchUpInside)
        self.btnNoBox.addTarget(self, action: #selector(self.noBox(sndr:)), for: .touchUpInside)
        self.btnAddWatch2.tag = 2
        self.btnAddWatch2.addTarget(self, action: #selector(self.openCamera(snder:)), for: .touchUpInside)
        self.btnAddWatch3.tag = 3
        self.btnAddWatch3.addTarget(self, action: #selector(self.openCamera(snder:)), for: .touchUpInside)
        self.btnAddWatch1.tag = 1
        self.btnAddWatch1.addTarget(self, action: #selector(self.openCamera(snder:)), for: .touchUpInside)
        self.btnCrossWatch2.addTarget(self, action: #selector(self.delWatch2), for: .touchUpInside)
        self.btnCrossWatch3.addTarget(self, action: #selector(self.delWatch3), for: .touchUpInside)
        
        self.btnEditWatch1.tag = 1
        self.btnEditWatch1.addTarget(self, action: #selector(self.editWatchImages(sndr:)), for: .touchUpInside)
        self.btnEditWatch2.tag = 2
        self.btnEditWatch2.addTarget(self, action: #selector(self.editWatchImages(sndr:)), for: .touchUpInside)
        self.btnEditWatch3.tag = 3
        self.btnEditWatch3.addTarget(self, action: #selector(self.editWatchImages(sndr:)), for: .touchUpInside)
        
        self.btnTakeWatch.tag = 1
        
        self.ddlMake.didSelect
        { selectedText, index, id in
            self.ddlMake.selectedIndex = id
            self.selectedMakeID = id
        }
        
    }
    
    @objc private func openCamera(snder:UIButton)
    {
        self.selectingImgType = snder.tag
        self.imagePicker = UIImagePickerController()
        let alertOptionCamera: UIAlertController = UIAlertController(title: "Please Select", message:nil, preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            
        }
        alertOptionCamera.addAction(cancelActionButton)
        
        
        let saveActionButton = UIAlertAction(title: "Take Photo", style: .default)
        { _ in
            //var imagePicker = UIImagePickerController()
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = .camera;
            self.imagePicker.allowsEditing = false
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        alertOptionCamera.addAction(saveActionButton)
        
        let deleteActionButton = UIAlertAction(title: "Choose Photo", style: .default)
        { _ in
            
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = .photoLibrary;
            self.imagePicker.allowsEditing = false
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
                self.imgWatch = selectedImage
                self.imgWatchShow.image = selectedImage
                self.stckWatchImages.isHidden = false
                self.constrainMakeTop.constant = 80
                self.constrainMainContantHeight.constant = currntHeight + 80
                self.btnAddWatch1.isHidden = true
                self.btnCrossWatch1.isHidden = false
                break
            case 2:
                self.imgWatch2.image = selectedImage
                self.btnCrossWatch2.isHidden = false
                self.imgWatch2.isHidden = false
                self.btnAddWatch2.isHidden = true
                self.imgSelectedWatch2 = selectedImage
                break
            case 3:
                self.imgWatch3.image = selectedImage
                self.btnCrossWatch3.isHidden = false
                self.imgWatch3.isHidden = false
                self.btnAddWatch3.isHidden = true
                self.imgSelectedWatch3 = selectedImage
                break
            default:
                break
            }
            self.imagePicker.dismiss(animated: true, completion: nil)
//           // self.selectingImgType = -1
//            let cropview = CropViewController(image: selectedImage)
//            cropview.delegate = self
//            self.present(cropview, animated: false, completion: nil)
            self.cropImageUsingCroper(selectedImage: selectedImage)
        }
    }
    
    private func cropImageUsingCroper(selectedImage:UIImage)
    {
        let cropview = CropViewController(image: selectedImage)
        cropview.delegate = self
        self.present(cropview, animated: false, completion: nil)
    }
    
    @objc private func yesPaperWork(sndr:UIButton)
    {
        sndr.isSelected = true
        self.paperWork = "true"
        btnNoPaperWork.isSelected = false
    }
    
    @objc private func noPaperWork(sndr:UIButton)
    {
        sndr.isSelected = true
        self.paperWork = "false"
        btnYesPaperWork.isSelected = false
    }
    
    @objc private func yesSerivePaper(sndr:UIButton)
    {
        self.servicePaper = "true"
        sndr.isSelected = true
        btnNoServicePaper.isSelected = false
    }
    
    @objc private func noSerivePaper(sndr:UIButton)
    {
        self.servicePaper = "false"
        sndr.isSelected = true
        btnYesServicePaper.isSelected = false
    }
    
    @objc private func yesBox(sndr:UIButton)
    {
        sndr.isSelected = true
        self.box = "true"
        btnNoBox.isSelected = false
    }
    
    @objc private func noBox(sndr:UIButton)
    {
        sndr.isSelected = true
        self.box = "false"
        btnYesBox.isSelected = false
    }
    
    @IBAction func btnCloseWatchVw(_ sender: Any)
    {
        //constrainMakeTop.constant = 15
        //self.stckWatchImages.isHidden = true
        let currntHeight = self.constrainMainContantHeight.constant
        //self.constrainMainContantHeight.constant = currntHeight - 80
        self.imgWatch = nil
        self.imgWatchShow.image = UIImage(named: "")
        self.btnCrossWatch1.isHidden = true
        self.btnAddWatch1.isHidden = false
    }

    @IBAction func btnBack(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func submitSell()
    {
//        if imgWatch == nil
//        {
//            self.present(ActionHandler.showAlert(message: "Please take/choose product picture"), animated: true, completion: nil)
//            return
//        }
//        if self.selectedMakeID == -1
//        {
//            self.present(ActionHandler.showAlert(message: "Please select make"), animated: true, completion: nil)
//            return
//        }
//        if self.txtModel.text == ""
//        {
//            self.present(ActionHandler.showAlert(message: "Please enter model"), animated: true, completion: nil)
//            return
//        }
////        if self.txtSubModel.text == ""
////        {
////            self.present(ActionHandler.showAlert(message: "Please enter sub model"), animated: true, completion: nil)
////            return
////        }
////        if self.txtDial.text == ""
////        {
////            self.present(ActionHandler.showAlert(message: "Please enter dial"), animated: true, completion: nil)
////            return
////        }
////        if self.txtSize.text == ""
////        {
////            self.present(ActionHandler.showAlert(message: "Please enter size"), animated: true, completion: nil)
////            return
////        }
//        if self.txtMaterial.text == ""
//        {
//            self.present(ActionHandler.showAlert(message: "Please enter material"), animated: true, completion: nil)
//            return
//        }
//        if self.txtWatchYear.text == ""
//        {
//            self.present(ActionHandler.showAlert(message: "Please enter watch year"), animated: true, completion: nil)
//            return
//        }
////        if self.txtCustomization.text == ""
////        {
////            self.present(ActionHandler.showAlert(message: "Please enter customization"), animated: true, completion: nil)
////            return
////        }
//        if self.paperWork == ""
//        {
//            self.present(ActionHandler.showAlert(message: "Please select paper work"), animated: true, completion: nil)
//            return
//        }
//        if self.servicePaper == ""
//        {
//            self.present(ActionHandler.showAlert(message: "Please select service papers"), animated: true, completion: nil)
//            return
//        }
//        if self.box == ""
//        {
//            self.present(ActionHandler.showAlert(message: "Please select box"), animated: true, completion: nil)
//            return
//        }
//        if self.txtSerialNo.text == ""
//        {
//            self.present(ActionHandler.showAlert(message: "Please enter serial no."), animated: true, completion: nil)
//            return
//        }
//        if self.txtPrice.text == ""
//        {
//            self.present(ActionHandler.showAlert(message: "Please enter price"), animated: true, completion: nil)
//            return
//        }
        self.editWatch()
    }
    
    @objc private func delWatch2()
    {
        self.imgWatch2.image = UIImage(named: "")
        self.imgSelectedWatch2 = nil
        self.btnAddWatch2.isHidden = false
        self.btnCrossWatch2.isHidden = true
    }
    
    @objc private func delWatch3()
    {
        self.imgWatch3.image = UIImage(named: "")
        self.imgSelectedWatch3 = nil
        self.btnAddWatch3.isHidden = false
        self.btnCrossWatch3.isHidden = true
    }
    
    @objc private func editWatchImages(sndr:UIButton)
    {
        self.selectingImgType = sndr.tag
        var selectedImage:UIImage!
        switch sndr.tag
        {
        case 1:
            selectedImage = self.imgWatch
            break
        case 2:
            selectedImage = self.imgSelectedWatch2
            break
        case 3:
            selectedImage = self.imgSelectedWatch3
            break
        default:
            break
        }
        self.cropImageUsingCroper(selectedImage: selectedImage)
    }
}
extension EditWatchVC:UITextViewDelegate //desicription
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
extension EditWatchVC //get make watch
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
                                self.arrName = []
                                self.arrID = []
                                for mk in dt
                                {
                                    let make = WatchMake.fromJSON(mk)
                                    self.arrName.append(make.name)
                                    self.arrID.append(Int(make.id)!)
                                }
                                self.ddlMake.optionIds = self.arrID
                                self.ddlMake.optionArray = self.arrName
                                if self.productDetail != nil
                                {
                                    self.selectMake()
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
    //getItemDetainByIDSer
    private func getProductDetailByID()
    {
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
        getItemDetaidByIDSer(id: self.productID) { response in
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
                            if let  dt = json["data"] as? [String:Any]
                            {
                                self.productDetail = WatchData.fromJSON(dt)
                               // self.imgWatchShow.sd_setImage(with: URL(string: self.productDetail.image), placeholderImage:UIImage(named: "placeholder.png"))
                                self.imgWatchShow.sd_setImage(with: URL(string: self.productDetail.image)) { img, err, SDImageCacheType, url in
                                    if img != nil
                                    {
                                        self.imgWatch = img
                                        let currntHeight = self.constrainMainContantHeight.constant
                                        self.stckWatchImages.isHidden = false
                                        self.btnCrossWatch1.isHidden = false
                                        self.btnAddWatch1.isHidden = true
                                        self.constrainMakeTop.constant = 80
                                        self.constrainMainContantHeight.constant = currntHeight + 80
                                    }
                                }
                                self.imgWatch2.sd_setImage(with: URL(string: self.productDetail.imgAdditional1)) { img, err, SDImageCacheType, url in
                                    if img != nil
                                    {
                                        //self.imgWatch2.image = img
                                        self.imgSelectedWatch2 = img
                                        self.imgWatch2.isHidden = false
                                       // let currntHeight = self.constrainMainContantHeight.constant
                                       // self.stckWatchImages.isHidden = false
                                        self.btnCrossWatch2.isHidden = false
                                        self.btnAddWatch2.isHidden = true
                                       // self.constrainMakeTop.constant = 80
                                       // self.constrainMainContantHeight.constant = currntHeight + 80
                                    }
                                }
                                self.imgWatch3.sd_setImage(with: URL(string: self.productDetail.imgAdditional2)) { img, err, SDImageCacheType, url in
                                    if img != nil
                                    {
                                       // self.imgWatch3.image = img
                                        self.imgWatch3.isHidden = false
                                        self.imgSelectedWatch3 = img
                                        self.btnCrossWatch3.isHidden = false
                                        self.btnAddWatch3.isHidden = true
                                    }
                                }
                                
                                self.txtModel.text = self.productDetail.model
                                self.txtSubModel.text = self.productDetail.subModel
                                self.txtDial.text = self.productDetail.dial
                                self.txtSize.text = self.productDetail.size
                                self.txtWatchYear.text = self.productDetail.watchYear
                                self.txtCustomization.text = self.productDetail.customisation
                                self.txtSerialNo.text = self.productDetail.serialNo
                                self.txtPrice.text = self.productDetail.purchasePrice
                                self.txtMaterial.text = self.productDetail.material
                                self.txtDescription.text = self.productDetail.descrption
                                if self.productDetail.paperWork.lowercased() == "true"
                                {
                                    self.btnYesPaperWork.isSelected = true
                                    self.btnNoPaperWork.isSelected = false
                                }
                                else
                                {
                                    self.btnYesPaperWork.isSelected = false
                                    self.btnNoPaperWork.isSelected = true
                                }
                                self.paperWork = self.productDetail.paperWork.lowercased() == "" ? "false" : "true"
                                if self.productDetail.servicePapers.lowercased() == "true"
                                {
                                    self.btnYesServicePaper.isSelected = true
                                    self.btnNoServicePaper.isSelected = false
                                }
                                else
                                {
                                    self.btnYesServicePaper.isSelected = false
                                    self.btnNoServicePaper.isSelected = true
                                }
                                self.servicePaper = self.productDetail.servicePapers.lowercased() == "" ? "false" : "true"
                                if self.productDetail.box.lowercased() == "true"
                                {
                                    self.btnYesBox.isSelected = true
                                    self.btnNoBox.isSelected = false
                                }
                                else
                                {
                                    self.btnYesBox.isSelected = false
                                    self.btnNoBox.isSelected = true
                                }
                                self.box = self.productDetail.box.lowercased() == "" ? "false" : "true"
                                self.selectMake()
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
    
    private func selectMake()
    {
        if let indx = self.arrID.firstIndex(where:{$0 == Int(self.productDetail.makeID)})
        {
            self.ddlMake.selectedIndex = indx
            self.ddlMake.text = self.productDetail.make
            self.selectedMakeID = Int(self.productDetail.makeID)!
        }
    }
}

extension EditWatchVC:UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if string == ""
        {
            // User presses backspace
            textField.deleteBackward()
        } else {
            // User presses a key or pastes
            textField.insertText(string.uppercased())
        }
        // Do not let specified text range to be changed
        return false
    }
}
extension EditWatchVC //api
{
    private func editWatch()
    {
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
        let descrp = self.txtDescription.text.lowercased() == "Description" ? "" : self.txtDescription.text
        let parameter = ["PurchaseID":self.productDetail.purchaseID,
                         "MakeID":"\(self.selectedMakeID)",
                         "SerialNo":self.txtSerialNo.text!,
                         "Model":self.txtModel.text!,
                         "SubModel":self.txtSubModel.text!,
                         "Size":self.txtSize.text!,
                         "Dial":self.txtDial.text!,
                         "Material":self.txtMaterial.text!,
                         "WatchYear":self.txtWatchYear.text!,
                         "Customisation":self.txtCustomization.text!,
                         "Description":descrp,
                         "PurchasePrice":self.txtPrice.text!,
                         "PaperWork":self.paperWork,
                         "ServicePapers":self.servicePaper,
                         "Box":self.box]
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 100
        configuration.timeoutIntervalForResource = 100
        
        alamoFireManager = Alamofire.Session(configuration: configuration)
        alamoFireManager!.upload(multipartFormData: { multipartFormData in
            if self.imgWatch != nil
            {
                let imgProduct = self.imgWatch.jpegData(compressionQuality: 0.3)!
                multipartFormData.append(imgProduct, withName: "ImageFile",fileName: "ImageFile.jpg", mimeType: "image/jpg")
            }
            
            if self.imgSelectedWatch2 != nil
            {
                let watch2 = self.imgSelectedWatch2.jpegData(compressionQuality: 0.3)!
                multipartFormData.append(watch2, withName: "ImgAdditional1File",fileName: "ImgAdditional1File.jpg", mimeType: "image/jpg")
            }
            if self.imgSelectedWatch3 != nil
            {
                let watch3 = self.imgSelectedWatch3.jpegData(compressionQuality: 0.3)!
                multipartFormData.append(watch3, withName: "ImgAdditional2File",fileName: "ImgAdditional2File.jpg", mimeType: "image/jpg")
            }
            
            for (key, value) in parameter {
                multipartFormData.append(((value)!.data(using: String.Encoding.utf8)!), withName: key)
            }
        },
                                 to: Constants.Server.baseUrl+"/JewelleryApi/EditProduct", usingThreshold: UInt64.init(), method: .post, headers: [:]).responseJSON{(response) in
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
                                    self.delegate.successEdit(productID: self.productID)
                                    self.dismiss(animated: true, completion: nil)
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
    
    private func fieldDataRemove()
    {
        self.vwWatchImg.isHidden = true
        self.imgWatch = nil
        self.constrainMakeTop.constant = 15
        self.ddlMake.text = ""
        self.selectedMakeID = -1
        self.txtSerialNo.text = ""
        self.txtPrice.text = ""
        self.txtWatchYear.text = ""
        self.constrainMainContantHeight.constant = 2150
        self.txtDescription.text = "DESCRIPTION"
        self.txtDescription.textColor = UIColor.lightGray
        self.txtSubModel.text = ""
        self.txtDial.text = ""
        self.txtSize.text = ""
        self.txtMaterial.text = ""
        self.txtCustomization.text = ""
        self.paperWork = ""
        self.servicePaper = ""
        self.box = ""
        self.btnYesPaperWork.isSelected = false
        self.btnNoPaperWork.isSelected = false
        self.btnYesServicePaper.isSelected = false
        self.btnNoServicePaper.isSelected = false
        self.btnYesBox.isSelected = false
        self.btnNoBox.isSelected = false
        self.txtModel.text = ""
       
    }
}
extension EditWatchVC:CropViewControllerDelegate
{
    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
        //self.imgWatch = image
        print("Croping cancelled \(cancelled)")
        cropViewController.dismiss(animated: true, completion: nil)
    }
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int)
    {
        switch self.selectingImgType {
        case 1:
            self.imgWatch = image
            self.imgWatchShow.image = image
        case 2:
            self.imgWatch2.image = image
            self.imgSelectedWatch2 = image
        case 3:
            self.imgWatch3.image = image
            self.imgSelectedWatch3 = image
        default:
            break
        }
        self.selectingImgType = -1
        cropViewController.dismiss(animated: true, completion: nil)
    }
}
