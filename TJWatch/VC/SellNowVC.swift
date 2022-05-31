//
//  SellNowVC.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 23/12/2021.
//

import UIKit
import RappleProgressHUD
import Alamofire
import iOSDropDown
import CropViewController

class SellNowVC: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var btnTakePhotoID: UIButton!
    @IBOutlet weak var btnTakePhotoAddress: UIButton!
    @IBOutlet weak var vwPrice: UIView!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtCustomerName: UITextField!
    @IBOutlet weak var txtBuyerContactNumber: UITextField!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var vwProofID: UIView!
    @IBOutlet weak var imgProof: UIImageView!
    @IBOutlet weak var vwProofAddress: UIView!
    @IBOutlet weak var imgProofAddress: UIImageView!
    @IBOutlet weak var btnSearchBuyerOL: UIButton!
    
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
    
    @IBOutlet weak var btnLiveDeposit: UIButton!
    @IBOutlet weak var btnExchange: UIButton!
    
    @IBOutlet weak var vwLiveDeposit: UIView!
    @IBOutlet weak var vwAdvLP: UIView!
    @IBOutlet weak var txtAdvLP: UITextField!
    @IBOutlet weak var vwRemainingLP: UIView!
    @IBOutlet weak var txtRemainingLP: UITextField!
    @IBOutlet weak var txtValidaty: UITextField!
    
    @IBOutlet weak var vwExchange: UIView!
   // @IBOutlet weak var txtUKNumber: UITextField!
    @IBOutlet weak var ddlMake: DropDown!
    @IBOutlet weak var txtModel: UITextField!
    @IBOutlet weak var txtSerialNo: UITextField!
    @IBOutlet weak var txtWatchYear: UITextField!
    @IBOutlet weak var txtSubModel: UITextField!
    @IBOutlet weak var txtCustomization: UITextField!
    @IBOutlet weak var txtMaterial: UITextField!
    @IBOutlet weak var txtDial: UITextField!
    @IBOutlet weak var txtSize: UITextField!

    @IBOutlet weak var btnYesPaperWork: UIButton!
    @IBOutlet weak var btnNoPaperWork: UIButton!
    @IBOutlet weak var btnYesServicePaper: UIButton!
    @IBOutlet weak var btnNoServicePaper: UIButton!
    @IBOutlet weak var btnYesBox: UIButton!
    @IBOutlet weak var btnNoBox: UIButton!
    
    @IBOutlet weak var btnUploadPhoto: UIButton!
    @IBOutlet weak var vwPhoto: UIView!
    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var vwPriceEx: UIView!
    @IBOutlet weak var txtPriceEx: UITextField!
    @IBOutlet weak var vwRemainingPriceEx: UIView!
    @IBOutlet weak var txtRemainingEx: UITextField!
    @IBOutlet weak var vwTotalBlncEx: UIView!
    @IBOutlet weak var txtTotalBlncEx: UITextField!
    
    @IBOutlet weak var vwDatePick: UIView!
    @IBOutlet weak var dtPickr: UIDatePicker!
    @IBOutlet weak var btnDoneDate: UIButton!
    @IBOutlet weak var btnCancelDate: UIButton!
    
    
    @IBOutlet weak var constrainTopDescriptn: NSLayoutConstraint! //15
    @IBOutlet weak var constrainTopPayment: NSLayoutConstraint!
    @IBOutlet weak var constrainContantViewHeight: NSLayoutConstraint! //1100
    @IBOutlet weak var constrainTopAddress: NSLayoutConstraint! //15 //60
    @IBOutlet weak var constrainTopSalePrice: NSLayoutConstraint! //15 //60
    @IBOutlet weak var constrainExchangeHeight: NSLayoutConstraint! //1004
    
    
    
    var productName = ""
    var productID = ""
    var imagePicker: UIImagePickerController!
    var imgProofID:UIImage!
    var imgAddress:UIImage!
    var imgBankReceipt:UIImage!
    var selectingImgType = -1
    var paymentType = ""  //values: "Cash"   "Bank"
    var alamoFireManager : Session?
    var clientID = "-1"
    var imgSelectedCard:UIImage!
    var imgSelectedWire:UIImage!
    var imgSelectedCrypto:UIImage!
    var imgSelectWatchPhoto:UIImage!
    var paperWork = ""
    var servicePaper = ""
    var box = ""
    var productType = 0
    var selectedMakeID = ""
    let green = UIColor(red: 18/255, green: 78/255, blue: 68/255, alpha: 1.0)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.constrainContantViewHeight.constant = 1150
        self.lblProductName.text = self.productName
        self.btnTakePhotoID.addTarget(self, action: #selector(self.openCamera(snder:)), for: .touchUpInside)
        self.btnTakePhotoID.tag = 1
       self.btnTakePhotoAddress.addTarget(self, action: #selector(self.openCamera(snder:)), for: .touchUpInside)
        self.btnTakePhotoAddress.tag = 2
        self.btnSubmit.addTarget(self, action: #selector(self.submitSell), for: .touchUpInside)
        
        //self.btnChooseID.vwCornerRadius(radius: 20)
        self.btnTakePhotoID.vwCornerRadius(radius: 20)
        self.btnTakePhotoAddress.vwCornerRadius(radius: 20)
        self.btnSubmit.vwCornerRadius(radius: 22)
        self.btnSearchBuyerOL.vwCornerRadius(radius: 18)
        self.vwPrice.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 22)
        self.txtCustomerName.setBrdBg()
        self.txtCustomerName.delegate = self
        self.txtBuyerContactNumber.setBrdBg()
        self.txtBuyerContactNumber.delegate = self
        self.txtEmail.setBrdBg()
        self.txtEmail.delegate = self
        
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
        
        self.btnYesPaperWork.addTarget(self, action: #selector(self.yesPaperWork(sndr:)), for: .touchUpInside)
        self.btnNoPaperWork.addTarget(self, action: #selector(self.noPaperWork(sndr:)), for: .touchUpInside)
        self.btnYesServicePaper.addTarget(self, action: #selector(self.yesSerivePaper(sndr:)), for: .touchUpInside)
        self.btnNoServicePaper.addTarget(self, action: #selector(self.noSerivePaper(sndr:)), for: .touchUpInside)
        self.btnYesBox.addTarget(self, action: #selector(self.yesBox(sndr:)), for: .touchUpInside)
        self.btnNoBox.addTarget(self, action: #selector(self.noBox(sndr:)), for: .touchUpInside)
        
        self.btnLiveDeposit.vwCornerRadius(radius: 18)
        self.btnExchange.vwCornerRadius(radius: 18)
        self.btnLiveDeposit.addTarget(self, action: #selector(self.selectLiveDeposit), for: .touchUpInside)
        self.btnExchange.addTarget(self, action: #selector(self.selectExchange), for: .touchUpInside)
        
        //live Deposit
        self.vwAdvLP.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 22)
        self.vwRemainingLP.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 22)
        self.txtRemainingLP.delegate = self
        self.txtValidaty.setBrdBg()
        self.txtValidaty.delegate = self
        self.dtPickr.date = Date()
        self.dtPickr.minimumDate = Date()
        self.btnDoneDate.addTarget(self, action: #selector(self.doneDate), for: .touchUpInside)
        self.btnCancelDate.addTarget(self, action: #selector(self.cancelDate), for: .touchUpInside)
        
        //
        self.txtPriceEx.addTarget(self, action: #selector(self.textChange(textField:)), for: .editingChanged)
        self.txtPrice.addTarget(self, action: #selector(self.textChange(textField:)), for: .editingChanged)
        self.txtAdvLP.addTarget(self, action: #selector(self.textChange(textField:)), for: .editingChanged)
       // self.txt.addTarget(self, action: #selector(self.textChange(textField:)), for: .editingChanged)
        
        //Exchange
       // self.txtUKNumber.setBrdBg()
       // self.txtUKNumber.delegate = self
        self.ddlMake.setBrdBg()
       // self.ddlMake.delegate = self
        self.txtModel.setBrdBg()
        self.txtModel.delegate = self
        self.txtSerialNo.setBrdBg()
        self.txtSerialNo.delegate = self
        self.txtWatchYear.setBrdBg()
        self.txtWatchYear.delegate = self
        self.txtSubModel.setBrdBg()
        self.txtSubModel.delegate = self
        self.txtCustomization.setBrdBg()
        self.txtCustomization.delegate = self
        self.txtMaterial.setBrdBg()
        self.txtMaterial.delegate = self
        self.txtDial.setBrdBg()
        self.txtDial.delegate = self
        self.txtSize.setBrdBg()
        self.txtSize.delegate = self
        self.txtPrice.delegate = self
        self.txtCash.delegate = self
        self.txtCard.delegate = self
        self.txtWire.delegate = self
        self.txtCrypto.delegate = self
        self.txtAdvLP.delegate = self
        self.txtPriceEx.delegate = self
        self.txtTotalBlncEx.delegate = self
        self.txtDescription.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 12)
        self.txtDescription.delegate = self
        self.vwPriceEx.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 22)
        self.vwRemainingPriceEx.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 22)
        self.vwTotalBlncEx.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 22)
        self.btnUploadPhoto.vwCornerRadius(radius: 20)
        self.btnUploadPhoto.tag = 3
        self.btnUploadPhoto.addTarget(self, action: #selector(self.openCamera(snder:)), for: .touchUpInside)
        self.ddlMake.didSelect { selectedText, index, id in
            self.ddlMake.selectedIndex = id
            self.selectedMakeID = "\(id)"
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.getMakeLst()
    }
    
    @objc private func doneDate()
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        self.txtValidaty.text = formatter.string(from: self.dtPickr.date)
        self.vwDatePick.isHidden = true
    }
    
    @objc private func cancelDate()
    {
        self.vwDatePick.isHidden = true
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
    }
    
    @objc private func submitSell()
    {
//        if imgProofID == nil
//        {
//            self.present(ActionHandler.showAlert(message: "Please take/choose proof of ID"), animated: true, completion: nil)
//            return
////        }
//        if imgAddress == nil
//        {
//            self.present(ActionHandler.showAlert(message: "Please take/choose proof of address"), animated: true, completion: nil)
//            return
//        }
        if self.txtPrice.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Please enter price"), animated: true, completion: nil)
            return
        }
        if self.txtCustomerName.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Please select customer"), animated: true, completion: nil)
            return
        }
//        if self.txtEmail.text == ""
//        {
//            self.present(ActionHandler.showAlert(message: "Please enter customer email address"), animated: true, completion: nil)
//            return
//        }
        if self.txtEmail.text != "" && !ActionHandler.isValidEmail(emailText: self.txtEmail.text!)
        {
            self.present(ActionHandler.showAlert(message: "Please incorrect email address"), animated: true, completion: nil)
            return
        }
//        if self.txtBuyerContactNumber.text == ""
//        {
//            self.present(ActionHandler.showAlert(message: "Please enter contact number"), animated: true, completion: nil)
//            return
//        }
//        if self.productType == 0
//        {
//            self.present(ActionHandler.showAlert(message: "Please select Live Deposit/ Exchange"), animated: true, completion: nil)
//            return
//        }
        if self.productType == 1
        {
            if self.txtAdvLP.text == ""
            {
                self.present(ActionHandler.showAlert(message: "Please enter advance payment"), animated: true, completion: nil)
                return
            }
            if self.txtValidaty.text == ""
            {
                self.present(ActionHandler.showAlert(message: "Please select validaty date"), animated: true, completion: nil)
                return
            }
        }
        if self.productType == 2
        {
//            if self.txtUKNumber.text == ""
//            {
//                self.present(ActionHandler.showAlert(message: "Please enter UK number"), animated: true, completion: nil)
//                return
//            }
            if self.selectedMakeID == ""
            {
                self.present(ActionHandler.showAlert(message: "Please select make"), animated: true, completion: nil)
                return
            }
            if self.txtModel.text == ""
            {
                self.present(ActionHandler.showAlert(message: "Please enter model"), animated: true, completion: nil)
                return
            }
            if self.txtSerialNo.text == ""
            {
                self.present(ActionHandler.showAlert(message: "Please enter serial number"), animated: true, completion: nil)
                return
            }
            if self.txtWatchYear.text == ""
            {
                self.present(ActionHandler.showAlert(message: "Please enter watch year"), animated: true, completion: nil)
                return
            }
            if self.txtDial.text == ""
            {
                self.present(ActionHandler.showAlert(message: "Please enter dial"), animated: true, completion: nil)
                return
            }
            if self.txtSize.text == ""
            {
                self.present(ActionHandler.showAlert(message: "Please enter size"), animated: true, completion: nil)
                return
            }
            if self.paperWork == ""
            {
                self.present(ActionHandler.showAlert(message: "Please select paper work"), animated: true, completion: nil)
                return
            }
            if self.servicePaper == ""
            {
                self.present(ActionHandler.showAlert(message: "Please select service papers"), animated: true, completion: nil)
                return
            }
            if self.box == ""
            {
                self.present(ActionHandler.showAlert(message: "Please select box"), animated: true, completion: nil)
                return
            }
            if self.imgSelectWatchPhoto == nil
            {
                self.present(ActionHandler.showAlert(message: "Please select watch image"), animated: true, completion: nil)
                return
            }
            if self.txtPriceEx.text == ""
            {
                self.present(ActionHandler.showAlert(message: "Please enter price"), animated: true, completion: nil)
                return
            }
            if self.txtTotalBlncEx.text == ""
            {
                self.present(ActionHandler.showAlert(message: "Please enter total balance"), animated: true, completion: nil)
                return
            }
        }
        
        if self.paymentType == "Bank" && self.imgBankReceipt == nil
        {
            self.present(ActionHandler.showAlert(message: "Please take bank receipt picture"), animated: true, completion: nil)
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
        self.submitSellNow()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let selectedImage =  info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            let currntHeight = self.constrainContantViewHeight.constant
            switch self.selectingImgType
            {
            case 1:
                self.imgProofID = selectedImage
                self.imgProof.image = selectedImage
                self.vwProofID.isHidden = false
                self.constrainTopAddress.constant = 80
                self.constrainContantViewHeight.constant = currntHeight + 80
                break
            case 2:
                self.imgAddress = selectedImage
                self.imgProofAddress.image = selectedImage
                self.vwProofAddress.isHidden = false
                self.constrainTopSalePrice.constant = 80
                self.constrainContantViewHeight.constant = currntHeight + 80
                break
            case 3:
                self.imgSelectWatchPhoto = selectedImage
                self.imgPhoto.image = selectedImage
                self.vwPhoto.isHidden = false
                self.constrainTopDescriptn.constant = 80
                self.constrainContantViewHeight.constant = currntHeight + 80
                self.constrainExchangeHeight.constant = 1004 + 80
                self.constrainTopPayment.constant = 1050 + 80
                break
            case 4:
                self.imgCard.image = selectedImage
                self.imgSelectedCard = selectedImage
                break
            case 5:
                self.imgWire.image = selectedImage
                self.imgSelectedWire = selectedImage
                break
            case 6:
                self.imgCrypto.image = selectedImage
                self.imgSelectedCrypto = selectedImage
                break
            default:
                break
            }
            self.imagePicker.dismiss(animated: true, completion: nil)
//            if self.selectingImgType == 3
//            {
//                let cropview = CropViewController(image: selectedImage)
//                cropview.delegate = self
//                self.present(cropview, animated: false, completion: nil)
//            }
          //  self.selectingImgType = -1
            self.cropImageUsingCroper(selectedImage: selectedImage)
        }
    }
    
    private func cropImageUsingCroper(selectedImage:UIImage)
    {
        let cropview = CropViewController(image: selectedImage)
        cropview.delegate = self
        self.present(cropview, animated: false, completion: nil)
    }
    
    @IBAction func btnBack(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCloseProofImgID(_ sender: Any)
    {
        constrainTopAddress.constant = 15
        let currntHeight = self.constrainContantViewHeight.constant
       // print(currntHeight)
        self.constrainContantViewHeight.constant = currntHeight - 80
        self.vwProofID.isHidden = true
        self.imgProofID = nil
    }
    
    @IBAction func btnCloseAddressImg(_ sender: Any)
    {
        constrainTopSalePrice.constant = 15
        self.vwProofAddress.isHidden = true
        let currntHeight = self.constrainContantViewHeight.constant
       // print(currntHeight)
        self.constrainContantViewHeight.constant = currntHeight - 80
        self.imgAddress = nil
    }
    
    @IBAction func btnCloseBankReceipt(_ sender: Any)
    {
        let currntHeight = self.constrainContantViewHeight.constant
       // print(currntHeight)
            self.constrainContantViewHeight.constant = currntHeight - 80
        self.imgBankReceipt = UIImage()
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
    @IBAction func btnValidatyDate(_ sender: Any)
    {
        UIView.animate(withDuration: 2) {
            self.view.bringSubviewToFront(self.vwDatePick)
            self.vwDatePick.isHidden = false
        }
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
    
    @IBAction func btnRemovePhoto(_ sender: Any)
    {
        let currntHeight = self.constrainContantViewHeight.constant
        self.constrainExchangeHeight.constant = 1004
        self.constrainTopPayment.constant = 1050
        self.constrainContantViewHeight.constant = currntHeight - 80
        self.vwPhoto.isHidden = true
        self.imgSelectWatchPhoto = nil
        self.constrainTopDescriptn.constant = 15
    }
    
    @objc private func selectLiveDeposit()
    {
        if productType == 1
        {
            let currntHeight = self.constrainContantViewHeight.constant
            self.constrainContantViewHeight.constant = self.productType == 2 ? (currntHeight - 1004) + 222 :  currntHeight -  222
            self.constrainTopPayment.constant = 15
            self.productType = 0
            self.vwLiveDeposit.isHidden = true
            self.btnLiveDeposit.backgroundColor = UIColor.lightGray
            //self.btnExchange.backgroundColor = UIColor.lightGray
        }
        else
        {
            let currntHeight = self.constrainContantViewHeight.constant
            self.btnLiveDeposit.backgroundColor = self.green
            self.btnExchange.backgroundColor = UIColor.lightGray
            self.vwLiveDeposit.isHidden = false
            self.vwExchange.isHidden = true
            self.constrainTopPayment.constant = 240
            self.constrainContantViewHeight.constant = self.productType == 2 ? (currntHeight - 1004) + 222 :  currntHeight +  222
            self.productType = 1
        }
        
    }
    
    @objc private func selectExchange()
    {
        if self.productType == 2
        {
            let currntHeight = self.constrainContantViewHeight.constant
            self.constrainContantViewHeight.constant = currntHeight -  1004
            self.productType = 0
            self.constrainTopPayment.constant = 15
            self.btnExchange.backgroundColor = UIColor.lightGray
            self.vwExchange.isHidden = true
            //self.btnLiveDeposit.backgroundColor = UIColor.lightGray
        }
        else
        {
            let currntHeight = self.constrainContantViewHeight.constant
            self.btnExchange.backgroundColor = self.green
            self.btnLiveDeposit.backgroundColor = UIColor.lightGray
            self.vwLiveDeposit.isHidden = true
            self.vwExchange.isHidden = false
            self.constrainTopPayment.constant = 1050
            self.constrainContantViewHeight.constant = self.productType == 1 ? (currntHeight - 222) + 1004 :  currntHeight +  1004
            self.productType = 2
        }
    }
    
    
    @IBAction func btnNotifications(_ sender: Any) {
        let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vw, animated: true)
    }
}

extension SellNowVC:UITextViewDelegate
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

extension SellNowVC:customerSearch
{
    func searchedClient(searched: Customer)
    {
        var currntHeight = self.constrainContantViewHeight.constant
        self.clientID = searched.id
        self.txtEmail.text = searched.email
        self.txtBuyerContactNumber.text = searched.phone
        self.txtCustomerName.text = searched.name
//        self.txtEmail.isUserInteractionEnabled = false
//        self.txtBuyerContactNumber.isUserInteractionEnabled = false
//        self.txtCustomerName.isUserInteractionEnabled = false
        self.imgProof.sd_setImage(with: URL(string: searched.proofIdImg), placeholderImage: UIImage(named: "placeholder"))
        self.imgProofID = self.imgProof.image
        self.constrainTopAddress.constant = 80
        //self.constrainMainContantHeight.constant = currntHeight + 80
        self.imgProofAddress.sd_setImage(with: URL(string: searched.proofAddressImg), placeholderImage: UIImage(named: "placeholder"))
        self.imgAddress = self.imgProofAddress.image
        currntHeight = self.constrainContantViewHeight.constant
        self.constrainContantViewHeight.constant = currntHeight + 190
        self.constrainTopSalePrice.constant = 80
        self.vwProofAddress.isHidden = false
        self.vwProofID.isHidden = false
    }
    
    func closeSearchClient()
    {
        self.txtEmail.text = ""
        self.txtBuyerContactNumber.text = ""
        self.txtCustomerName.text = ""
//        self.txtEmail.isUserInteractionEnabled = true
//        self.txtBuyerContactNumber.isUserInteractionEnabled = true
//        self.txtCustomerName.isUserInteractionEnabled = true
        self.imgProofID = nil
        self.vwProofID.isHidden = true
        self.constrainTopAddress.constant = 15
        self.imgAddress = nil
        self.constrainTopSalePrice.constant = 15
        self.vwProofAddress.isHidden = true
        self.clientID = "-1"
        self.constrainContantViewHeight.constant = 850
    }
    
}
extension SellNowVC //api
{
    func submitSellNow()
    {
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
        //live deposit
        let advLD = self.productType == 1 ? self.txtAdvLP.text! : ""
        let remLD = self.productType == 1 ? self.txtRemainingLP.text! : ""
        let validDate = self.productType == 1 ? self.txtValidaty.text! : ""
        
        //exchange
        let make = self.productType == 2 ? self.selectedMakeID : ""
        let model = self.productType == 2 ? self.txtModel.text! : ""
        let subModel = self.productType == 2 ? self.txtSubModel.text! : ""
        let size = self.productType == 2 ? self.txtSize.text! : ""
        let watchYear = self.productType == 2 ? self.txtWatchYear.text! : ""
        let customiz = self.productType == 2 ? self.txtCustomization.text! : ""
        let descptn = self.productType == 2 ? self.txtDescription.text == "DESCRIPTION" ? "" : self.txtDescription.text! : ""
        let serialNo = self.productType == 2 ? self.txtSerialNo.text! : ""
        let dial = self.productType == 2 ? self.txtDial.text! : ""
        let material = self.productType == 2 ? self.txtMaterial.text! : ""
        let paper = self.productType == 2 ? self.paperWork : ""
        let servicePaper = self.productType == 2 ? self.servicePaper : ""
        let box = self.productType == 2 ? self.box : ""
        let purchPricEx = self.productType == 2 ? self.txtPriceEx.text! : ""
        let blanc = self.productType == 2 ? self.txtTotalBlncEx.text! : ""
//        let dial = self.productType == 2 ? self.txtDial.text! : ""
//        let dial = self.productType == 2 ? self.txtDial.text! : ""
        
        
        let parameter = ["ProductID":self.productID,"BuyerName":self.txtCustomerName.text!,"BuyerEmail":self.txtEmail.text!, "BuyerContactNo":self.txtBuyerContactNumber.text!, "SalePrice":self.txtPrice.text!, "UserID":SharedManager.sharedInstance.userData.id, "ClientID":self.clientID, "Card":self.txtCard.text!, "Cash":self.txtCash.text!, "Crypto":self.txtCrypto.text!, "Wire":self.txtWire.text!, "MakeID":make, "Model":model, "Submodel":subModel, "Size": size, "WatchYear":watchYear, "Customisation":customiz, "Description":descptn, "SerialNo":serialNo, "Dial":dial, "Material":material, "PaperWork":paper, "ServicePaper": servicePaper, "Box":box, "PurchasePrice":purchPricEx, "BalancePayment":blanc, "AdvancePayment":advLD, "ValidityDate":validDate]
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 100
        configuration.timeoutIntervalForResource = 100
        
        alamoFireManager = Alamofire.Session(configuration: configuration)
        alamoFireManager!.upload(multipartFormData: { multipartFormData in
            if self.imgProofID != nil
            {
                let mugImgData = self.imgProofID.jpegData(compressionQuality: 0.2)!
                multipartFormData.append(mugImgData, withName: "ImgProofOfID",fileName: "ImgProofOfID.jpg", mimeType: "image/jpg")
            }
            
            if self.imgAddress != nil
            {
                let imgAddress = self.imgAddress.jpegData(compressionQuality: 0.2)!
                multipartFormData.append(imgAddress, withName: "ImgProofOfAddress",fileName: "ImgProofOfAddress.jpg", mimeType: "image/jpg")
            }
            
//            if self.imgBankReceipt != nil
//            {
//                multipartFormData.append(mugImgData, withName: "ImgPayType",fileName: "ImgPayType.jpg", mimeType: "image/jpg")
//            }
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
            
            if self.imgSelectWatchPhoto != nil
            {
                let photo = self.imgSelectWatchPhoto.jpegData(compressionQuality: 0.3)!
                multipartFormData.append(photo, withName: "ImgProduct",fileName: "ImgProduct.jpg", mimeType: "image/jpg")
            }
            
            for (key, value) in parameter {
                multipartFormData.append(((value).data(using: String.Encoding.utf8)!), withName: key)
            }
        },
                                 to: Constants.Server.baseUrl+"/JewelleryApi/SellProduct", usingThreshold: UInt64.init(), method: .post, headers: [:]).responseJSON{(response) in
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
                                let alert = UIAlertController(title: "Alert!", message: msg, preferredStyle: UIAlertController.Style.alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { UIAlertAction in
                                        NotificationCenter.default.post(name: NSNotification.Name("dismisView"), object: nil)
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
}
extension SellNowVC:UITextFieldDelegate
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
            if self.txtPrice == textField || textField == self.txtCash || textField == self.txtCard || textField == self.txtWire || self.txtCrypto == textField || textField == self.txtPriceEx || self.txtAdvLP == textField || self.txtTotalBlncEx == textField
            {
                print("Text:: \(textField.text!)")
                let commaStr = ActionHandler.addComma(amount: textField.text! == "" ? string : textField.text!+string)
                print("comma Separated:: \(commaStr)")
                textField.text = commaStr
                self.textChange(textField: textField)
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
extension SellNowVC //get make watch
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
    
    @objc private func textChange(textField:UITextField)
    {
        if self.txtPriceEx == textField
        {
            let remaining = Double(self.txtPrice.text != "" ? self.txtPrice.text!.replacingOccurrences(of: ",", with: "") : "0")! - Double(self.txtPriceEx.text != "" ? self.txtPriceEx.text!.replacingOccurrences(of: ",", with: "") : "0")!
            self.txtRemainingEx.text = "\(remaining)"
        }
        
        else if self.txtPrice == textField
        {
            if self.productType == 1
            {
                let remaining = Double(self.txtPrice.text != "" ? self.txtPrice.text!.replacingOccurrences(of: ",", with: "") : "0")! - Double(self.txtAdvLP.text != "" ? self.txtAdvLP.text!.replacingOccurrences(of: ",", with: "") : "0")!
                self.txtRemainingLP.text =  ActionHandler.addComma(amount: String(format: "%0.0f", remaining))
            }
            if self.productType == 2
            {
                let remaining = Double(self.txtPrice.text != "" ? self.txtPrice.text!.replacingOccurrences(of: ",", with: "") : "0")! - Double(self.txtPriceEx.text != "" ? self.txtPriceEx.text!.replacingOccurrences(of: ",", with: "") : "0")!
                
                self.txtRemainingEx.text = ActionHandler.addComma(amount: String(format: "%0.0f", remaining))
            }
        }
        
        else if self.txtAdvLP == textField
        {
            let remaining = Double(self.txtPrice.text != "" ? self.txtPrice.text!.replacingOccurrences(of: ",", with: "") : "0")! - Double(self.txtAdvLP.text != "" ? self.txtAdvLP.text!.replacingOccurrences(of: ",", with: "") : "0")!
            self.txtRemainingLP.text =  ActionHandler.addComma(amount: String(format: "%0.0f", remaining))
        }
    }
    
}
extension SellNowVC:CropViewControllerDelegate
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
        case 1:
            self.imgProofID = image
            self.imgProof.image = image
            break
        case 2:
            self.imgAddress = image
            self.imgProofAddress.image = image
            break
        case 3:
            self.imgSelectWatchPhoto = image
            self.imgPhoto.image = image
            break
        case 4:
            self.imgCard.image = image
            self.imgSelectedCard = image
            break
        case 5:
            self.imgWire.image = image
            self.imgSelectedWire = image
            break
        case 6:
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
