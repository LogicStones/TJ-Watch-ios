//
//  BuyVC.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 23/12/2021.
//

import UIKit
import iOSDropDown
import RappleProgressHUD
import Alamofire
import SideMenu
import SDWebImage
import CropViewController

class BuyVC: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIViewControllerTransitioningDelegate
{
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSellerName: UITextField!
    @IBOutlet weak var txtContactNumber: UITextField!
    @IBOutlet weak var btnProofID: UIButton!
    
    @IBOutlet weak var btnTakeAddressID: UIButton!
    @IBOutlet weak var btnTakeWatch: UIButton!
    @IBOutlet weak var ddlMake: DropDown!
    @IBOutlet weak var txtModel: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var vwPrice: UIView!
    @IBOutlet weak var txtWatchYear: UITextField!
    @IBOutlet weak var txtSerialNo: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var vwProofID: UIView!
    @IBOutlet weak var imgProof: UIImageView!
    @IBOutlet weak var vwProofAddress: UIView!
    @IBOutlet weak var imgProofAddress: UIImageView!
    @IBOutlet weak var vwWatchImg: UIView!
    @IBOutlet weak var imgWatchShow: UIImageView!
    @IBOutlet weak var btnSearchSellerOL: UIButton!
    
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
    
    @IBOutlet weak var ddlPurchaseType: DropDown!
    
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
    
    @IBOutlet weak var btnMenuOL: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
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
    @IBOutlet weak var constrainWtchTop: NSLayoutConstraint! //15 /80
    @IBOutlet weak var constrainProofAdressTop: NSLayoutConstraint! //15 //80
    
    var selectedMakeID = -1
    var paperWork = ""
    var servicePaper = ""
    var box = ""
    var imgProofID:UIImage!
    var imgAddress:UIImage!
    var imgWatch:UIImage!
    var selectingImgType = -1
    var paymentType = ""  //values: "Cash"   "Bank"
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
    var imgSelectedWatch2:UIImage!
    var imgSelectedWatch3:UIImage!
    
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
        self.ddlPurchaseType.setBrdBg()
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
        self.txtCash.delegate = self
        self.txtCard.delegate = self
        self.txtWire.delegate = self
        self.txtCrypto.delegate = self
        self.txtPrice.delegate = self
        self.btnProofID.vwCornerRadius(radius: 20)
        self.btnTakeAddressID.vwCornerRadius(radius: 20)
        self.btnTakeWatch.vwCornerRadius(radius: 20)
        self.btnSearchSellerOL.vwCornerRadius(radius: 18)
        self.btnSubmit.vwCornerRadius(radius: 22)
        self.vwPrice.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 22)
        
        self.btnProofID.addTarget(self, action: #selector(self.openCamera(snder:)), for: .touchUpInside)
        self.btnTakeAddressID.addTarget(self, action: #selector(self.openCamera(snder:)), for: .touchUpInside)
        
        self.btnTakeWatch.addTarget(self, action: #selector(self.openCamera(snder:)), for: .touchUpInside)
        self.btnSubmit.addTarget(self, action: #selector(self.submitSell), for: .touchUpInside)
        self.btnYesPaperWork.addTarget(self, action: #selector(self.yesPaperWork(sndr:)), for: .touchUpInside)
        self.btnNoPaperWork.addTarget(self, action: #selector(self.noPaperWork(sndr:)), for: .touchUpInside)
        self.btnYesServicePaper.addTarget(self, action: #selector(self.yesSerivePaper(sndr:)), for: .touchUpInside)
        self.btnNoServicePaper.addTarget(self, action: #selector(self.noSerivePaper(sndr:)), for: .touchUpInside)
        self.btnYesBox.addTarget(self, action: #selector(self.yesBox(sndr:)), for: .touchUpInside)
        self.btnNoBox.addTarget(self, action: #selector(self.noBox(sndr:)), for: .touchUpInside)
        self.btnAddWatch2.tag = 7
        self.btnAddWatch2.addTarget(self, action: #selector(self.openCamera(snder:)), for: .touchUpInside)
        self.btnAddWatch3.tag = 8
        self.btnAddWatch3.addTarget(self, action: #selector(self.openCamera(snder:)), for: .touchUpInside)
        self.btnAddWatch1.tag = 3
        self.btnAddWatch1.addTarget(self, action: #selector(self.openCamera(snder:)), for: .touchUpInside)
        self.btnCrossWatch2.addTarget(self, action: #selector(self.delWatch2), for: .touchUpInside)
        self.btnCrossWatch3.addTarget(self, action: #selector(self.delWatch3), for: .touchUpInside)
        
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
        
        self.btnEditWatch1.tag = 3
        self.btnEditWatch1.addTarget(self, action: #selector(self.editWatchImages(sndr:)), for: .touchUpInside)
        self.btnEditWatch2.tag = 7
        self.btnEditWatch2.addTarget(self, action: #selector(self.editWatchImages(sndr:)), for: .touchUpInside)
        self.btnEditWatch3.tag = 8
        self.btnEditWatch3.addTarget(self, action: #selector(self.editWatchImages(sndr:)), for: .touchUpInside)
        
        self.btnProofID.tag = 1
        self.btnTakeAddressID.tag = 2
        self.btnTakeWatch.tag = 3
        
        self.ddlMake.didSelect
        { selectedText, index, id in
            self.ddlMake.selectedIndex = id
            self.selectedMakeID = id
        }
        
        self.ddlPurchaseType.didSelect { selectedText, index, id in
            if id == 2
            {
                let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PendingOrders") as! PendingOrders
                vw.isFromBuy = true
                vw.delegate = self
                self.navigationController?.pushViewController(vw, animated: false)
            }
            self.selectedPurchaseType = "\(id)"
        }
        
        if self.isFromMenu
        {
            self.btnBack.isHidden = true
            self.btnMenuOL.isHidden = false
        }
        else
        {
            self.btnBack.isHidden = false
            self.btnMenuOL.isHidden = true
        }
        
        self.btnBack.addTarget(self, action: #selector(self.backView), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        if self.selectedMakeID == -1
        {
            self.getMakeLst()
        }
        if self.arrPurchaseID.count == 0
        {
            self.getBuyTypesLst()
        }
        //self.getBoxPaperLst()
        //fieldDataRemove()
    }
    
    @IBAction func btnMenu(_ sender: Any) {
        let menu = storyboard!.instantiateViewController(withIdentifier: "sidemenu") as! SideMenuNavigationController
        menu.transitioningDelegate = self
        present(menu, animated: true, completion: nil)
    }
    
    @objc private func backView()
    {
        self.navigationController?.popViewController(animated: true)
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
    
    @objc private func submitSell()
    {
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
        if self.txtSellerName.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Please enter seller name"), animated: true, completion: nil)
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
        if imgWatch == nil
        {
            self.present(ActionHandler.showAlert(message: "Please take/choose product picture"), animated: true, completion: nil)
            return
        }
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
//        if self.txtSubModel.text == ""
//        {
//            self.present(ActionHandler.showAlert(message: "Please enter sub model"), animated: true, completion: nil)
//            return
//        }
//        if self.txtDial.text == ""
//        {
//            self.present(ActionHandler.showAlert(message: "Please enter dial"), animated: true, completion: nil)
//            return
//        }
//        if self.txtSize.text == ""
//        {
//            self.present(ActionHandler.showAlert(message: "Please enter size"), animated: true, completion: nil)
//            return
//        }
        if self.txtMaterial.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Please enter material"), animated: true, completion: nil)
            return
        }
//        if self.txtWatchYear.text == ""
//        {
//            self.present(ActionHandler.showAlert(message: "Please enter watch year"), animated: true, completion: nil)
//            return
//        }
//        if self.txtCustomization.text == ""
//        {
//            self.present(ActionHandler.showAlert(message: "Please enter customization"), animated: true, completion: nil)
//            return
//        }
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
        if self.txtSerialNo.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Please enter serial no."), animated: true, completion: nil)
            return
        }
        if self.txtPrice.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Please enter price"), animated: true, completion: nil)
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
        
        self.buyWatch()
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
                self.constrainWtchTop.constant = 80
                self.constrainMainContantHeight.constant = currntHeight + 80
                break
            case 3:
                self.imgWatch = selectedImage
                self.imgWatchShow.image = selectedImage
                self.stckWatchImages.isHidden = false
                self.constrainMakeTop.constant = 80
                self.constrainMainContantHeight.constant = currntHeight + 80
                self.btnAddWatch1.isHidden = true
                self.btnCrossWatch1.isHidden = false
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
            case 7:
                self.imgWatch2.image = selectedImage
                self.btnCrossWatch2.isHidden = false
                self.imgWatch2.isHidden = false
                self.btnAddWatch2.isHidden = true
                self.imgSelectedWatch2 = selectedImage
                break
            case 8:
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
    @IBAction func btnCloseAddressImg(_ sender: Any)
    {
        constrainWtchTop.constant = 15
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
    
    @IBAction func btnNotifications(_ sender: Any)
    {
        let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vw, animated: true)
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
}
extension BuyVC:customerSearch
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
        self.constrainWtchTop.constant = 80
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
        self.constrainWtchTop.constant = 15
        self.vwProofAddress.isHidden = true
        self.clientID = "-1"
    }
    
    @objc private func editWatchImages(sndr:UIButton)
    {
        self.selectingImgType = sndr.tag
        var selectedImage:UIImage!
        switch sndr.tag
        {
        case 3:
            selectedImage = self.imgWatch
            break
        case 7:
            selectedImage = self.imgSelectedWatch2
            break
        case 8:
            selectedImage = self.imgSelectedWatch3
            break
        default:
            break
        }
        self.cropImageUsingCroper(selectedImage: selectedImage)
    }
    
}
extension BuyVC:UITextViewDelegate //desicription
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
extension BuyVC //get make watch
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
    
    private func getBuyTypesLst()
    {
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
        getBuyTypesSer{ response in
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
                                self.arrPurchaseID = []
                                self.arrPurchaseName = []
                                for mk in dt
                                {
                                    let buy = BuyTypes.fromJSON(mk)
                                    self.arrPurchaseName.append(buy.text)
                                    self.arrPurchaseID.append(Int(buy.value)!)
                                }
                                self.ddlPurchaseType.optionIds = self.arrPurchaseID
                                self.ddlPurchaseType.optionArray = self.arrPurchaseName
                                self.ddlPurchaseType.selectedIndex = 0
                                self.ddlPurchaseType.text = self.arrPurchaseName[0]
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
extension BuyVC //api
{
    private func buyWatch()
    {
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
        let descrp = self.txtDescription.text.lowercased() == "Description" ? "" : self.txtDescription.text
        let parameter = ["UserID":SharedManager.sharedInstance.userData.id,
                         "MakeID":"\(self.selectedMakeID)",
                         "Model":self.txtModel.text!,
                         "PurchasePayType":self.paymentType,
                         "PurchasePrice":self.txtPrice.text!,
                         "WatchYear":self.txtWatchYear.text!,
                         "Description":descrp,
                         "SellerContactNo":self.txtContactNumber.text!,
                         "SellerEmail":self.txtEmail.text!,
                         "SellerName":self.txtSellerName.text!,
                         "SerialNo":self.txtSerialNo.text!,
                         "ClientID":self.clientID,
                         "SubModel":self.txtSubModel.text!,
                         "Dial":self.txtDial.text!,
                         "Size":self.txtSize.text!,
                         "Material":self.txtMaterial.text!,
                         "Customisation":self.txtCustomization.text!,
                         "PaperWork":self.paperWork,
                         "ServicePaper":self.servicePaper,
                         "Box":self.box,
                         "Card":self.txtCard.text!,
                         "Cash":txtCash.text!,
                         "Crypto":txtCrypto.text!,
                         "Wire":self.txtWire.text!,
                         "ProductType":self.selectedPurchaseType,
                         "PendingOrderId":self.selectedWatch != nil ?  self.selectedWatch.id : ""]
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 100
        configuration.timeoutIntervalForResource = 100
        
        alamoFireManager = Alamofire.Session(configuration: configuration)
        alamoFireManager!.upload(multipartFormData: { multipartFormData in
            
            if self.imgProofID != nil
            {
            let mugImgData = self.imgProofID.jpegData(compressionQuality: 0.3)!
            multipartFormData.append(mugImgData, withName: "ImgProofOfID",fileName: "ImgProofOfID.jpg", mimeType: "image/jpg")
            }
            
            if self.imgAddress != nil
            {
            let imgAddress = self.imgAddress.jpegData(compressionQuality: 0.3)!
            multipartFormData.append(imgAddress, withName: "ImgProofOfAddress",fileName: "ImgProofOfAddress.jpg", mimeType: "image/jpg")
            }
            
            if self.imgWatch != nil
            {
                let imgProduct = self.imgWatch.jpegData(compressionQuality: 0.3)!
                multipartFormData.append(imgProduct, withName: "ImgProduct",fileName: "ImgProduct.jpg", mimeType: "image/jpg")
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
            
            for (key, value) in parameter
            {
                multipartFormData.append(((value)!.data(using: String.Encoding.utf8)!), withName: key)
            }
        },
                                 to: Constants.Server.baseUrl+"/JewelleryApi/BuyProduct", usingThreshold: UInt64.init(), method: .post, headers: [:]).responseJSON{(response) in
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
                                    self.tabBarController?.selectedIndex = 2
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
        self.txtEmail.text = ""
        self.txtSellerName.text = ""
        self.txtContactNumber.text = ""
        self.imgProofID = nil
        self.vwProofID.isHidden = true
        self.constrainProofAdressTop.constant = 15
        self.imgAddress = nil
        self.vwProofAddress.isHidden = true
        self.constrainWtchTop.constant = 15
        self.stckWatchImages.isHidden = true
        self.imgWatch = nil
        self.constrainMakeTop.constant = 15
        self.ddlMake.text = ""
        self.selectedMakeID = -1
        self.txtSerialNo.text = ""
        self.txtPrice.text = ""
        self.paymentType = ""
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
        self.txtEmail.isUserInteractionEnabled = true
        self.txtSellerName.isUserInteractionEnabled = true
        self.txtContactNumber.isUserInteractionEnabled = true
        self.imgWire.image = UIImage(named: "Sample_image")
        self.imgCard.image = UIImage(named: "Sample_image")
        self.imgCrypto.image = UIImage(named: "Sample_image")
        self.imgSelectedWire = nil
        self.imgSelectedCard = nil
        self.imgSelectedCrypto = nil
        self.imgSelectedWatch2 = nil
        self.imgSelectedWatch3 = nil
        self.imgWatch2.image = UIImage(named: "")
        self.imgWatch3.image = UIImage(named: "")
        self.imgWatch2.isHidden = true
        self.imgWatch3.isHidden = true
        self.btnCrossWatch2.isHidden = true
        self.btnCrossWatch3.isHidden = true
        self.btnAddWatch2.isHidden = false
        self.btnAddWatch3.isHidden = false
        self.txtCash.text = ""
        self.txtCard.text = ""
        self.txtWire.text = ""
        self.txtCrypto.text = ""
    }
}
//extension BuyVC //getBoxPaperListSer
//{
//    private func getBoxPaperLst()
//    {
//        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
//        getBoxPaperListSer{ response in
//            switch(response.result)
//            {
//            case .success(_):
//                RappleActivityIndicatorView.stopAnimation()
//                if let _JSON = response.data
//                {
//                    if let json = try! JSONSerialization.jsonObject(with: _JSON) as? [String:Any]
//                    {
//                        if json["error"] as! Bool
//                        {
//                            if let msg = json["message"] as? String
//                            {
//                                self.present(ActionHandler.showAlertPopViewController(message: msg, vw: self), animated: true, completion: nil)
//                                //  self.present(ActionHandler.showAlert(message: msg), animated: true, completion: nil)
//                            }
//                            else
//                            {
//                                self.present(ActionHandler.showAlert(message: Constants.messgs.somethingWrong), animated: true, completion: nil)
//                            }
//                        }
//                        else
//                        {
//                            if let dt = json["data"] as? [[String:Any]]
//                            {
//                                var arrName:[String] = []
//                                var arrID:[Int] = []
//                                for mk in dt
//                                {
//                                    let make = BoxPaper.fromJSON(mk)
//                                    arrName.append(make.text)
//                                    arrID.append(Int(make.value)!)
//                                }
//                                self.ddlBoxPaper.optionIds = arrID
//                                self.ddlBoxPaper.optionArray = arrName
//                            }
//                        }
//                    }
//                }
//                break
//            case .failure(_):
//                RappleActivityIndicatorView.stopAnimation()
//                self.present(ActionHandler.showAlert(message: Constants.messgs.somethingWrong), animated: true, completion: nil)
//                break
//            }
//        }
//    }
//}
extension BuyVC:UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if string == ""
        {
            // User presses backspace
            textField.deleteBackward()
        } else {
            // User presses a key or pastes
            if self.txtPrice == textField || textField == self.txtCash || textField == self.txtCard || textField == self.txtWire || self.txtCrypto == textField 
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
extension BuyVC:AddWatchDelegate
{
    func addWatch(watch: PendingOrdersModel)
    {
        self.selectedWatch = watch
    }
    
    func cancelAddWatch()
    {
        self.ddlPurchaseType.selectedIndex = 0
        self.selectedPurchaseType = "1"
    }
    
    
}
extension BuyVC:CropViewControllerDelegate
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
        case 3:
            self.imgWatch = image
            self.imgWatchShow.image = image
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
        case 7:
            self.imgWatch2.image = image
            self.imgSelectedWatch2 = image
            break
        case 8:
            self.imgWatch3.image = image
            self.imgSelectedWatch3 = image
            break
        default:
            break
        }
//        switch self.selectingImgType
//        {
//        case 3:
//            self.imgWatch = image
//            self.imgWatchShow.image = image
//        case 7:
//            self.imgWatch2.image = image
//            self.imgSelectedWatch2 = image
//        case 8:
//            self.imgWatch3.image = image
//            self.imgSelectedWatch3 = image
//        default:
//            break
//        }
        self.selectingImgType = -1
        cropViewController.dismiss(animated: true, completion: nil)
    }
}
