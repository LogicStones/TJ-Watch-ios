//
//  SellDetailVC.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 23/12/2021.
//

import UIKit
import RappleProgressHUD
import SDWebImage
import Alamofire
import ImageSlideshow
import AlamofireImage

class SellDetailVC: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblSerialNo: UILabel!
    @IBOutlet weak var lblWatcNo: UILabel!
    @IBOutlet weak var lblModel: UILabel!
    @IBOutlet weak var lblSubModel: UILabel!
    @IBOutlet weak var lblCustomization: UILabel!
    @IBOutlet weak var lblDail: UILabel!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var editPhoto: UIButton!
    @IBOutlet weak var btnSellNow: UIButton!
    @IBOutlet weak var lblPaperWork: UILabel!
    @IBOutlet weak var lblBox: UILabel!
    @IBOutlet var vwSlidImage: ImageSlideshow!
    @IBOutlet var lblSellerName: UILabel!
    
    var productID = ""
    var producrDetai:WatchData!
    var imagePicker: UIImagePickerController!
    var alamoFireManager : Session?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.txtDescription.delegate = self
        self.getStockDetail()
        self.btnSellNow.vwCornerRadius(radius: 22)
        self.imgProduct.vwCornerRadius(radius: 10)
        self.txtDescription.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 8)
        self.btnSellNow.addTarget(self, action: #selector(self.sellNow), for: .touchUpInside)
        self.editPhoto.addTarget(self, action: #selector(self.updatePhoto), for: .touchUpInside)
        self.editPhoto.vwCornerRadius(radius: 16)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        self.vwSlidImage.addGestureRecognizer(gestureRecognizer)
        }

        @objc private func didTap() {
            self.vwSlidImage.presentFullScreenController(from: self)
        }
    
    @objc private func sellNow()
    {
        let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SellNowVC") as! SellNowVC
        vw.modalPresentationStyle = .overFullScreen
        vw.productID = self.producrDetai.purchaseID
        vw.productName = self.producrDetai.make + " " + self.producrDetai.model
        self.present(vw, animated: true, completion: nil)
    }
    
    @IBAction func btnBack(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func updatePhoto()
    {
        let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditWatchVC") as! EditWatchVC
        vw.productID = self.productID
        vw.delegate = self
        vw.modalPresentationStyle = .fullScreen
        self.present(vw, animated: true, completion: nil)
    }
    
    @objc private func openCamera()
    {
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let selectedImage =  info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            self.uploadPhoto(selectedImage: selectedImage)
            self.imagePicker.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func btnNotifications(_ sender: Any) {
        let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vw, animated: true)
    }
}
extension SellDetailVC:UITextViewDelegate
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
extension SellDetailVC //api
{
    private func getStockDetail()
    {
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
        getStockDetailSer(id: productID) { response in
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
                                let wt = WatchData.fromJSON(dt)
                                self.producrDetai = wt
                                self.lblName.text = wt.make + " " + wt.model
                                self.lblSize.text =  wt.size
                                self.lblYear.text = wt.watchYear
                                self.txtDescription.text = wt.descrption
                                self.txtDescription.textColor = wt.descrption == "" ? UIColor.lightGray : UIColor.black
                                self.lblWatcNo.text = wt.ukWatchNo
                                self.lblSerialNo.text = wt.serialNo
                                self.lblModel.text = wt.model
                                self.lblSubModel.text = wt.subModel
                                self.lblCustomization.text = wt.customisation
                                self.lblDail.text = wt.dial
                                self.lblPrice.text = "£"+wt.purchasePrice
                                self.lblPaperWork.text = wt.paperWork.lowercased() == "true" ? "Yes" : "No"
                                self.lblBox.text = wt.box.lowercased() == "true" ? "Yes" : "No"
                                self.vwSlidImage.slideshowInterval = 10.0
                                self.lblSellerName.text = wt.sellerName
                                //vwImageSlider.pageControlPosition = PageControlPosition.underScrollView
                                let pageIndicator = UIPageControl()
                                pageIndicator.currentPageIndicatorTintColor = Constants.appColors.green
                                pageIndicator.pageIndicatorTintColor = UIColor.lightGray
                                self.vwSlidImage.pageIndicator = pageIndicator
                                self.vwSlidImage.contentScaleMode = UIViewContentMode.scaleAspectFill
                                self.vwSlidImage.clipsToBounds = true
                                
                                // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
                                self.vwSlidImage.activityIndicator = DefaultActivityIndicator()
                                self.vwSlidImage.currentPageChanged = { page in
                                    print("current page:", page)
                                }
                                var localSource = [AlamofireSource(urlString: "")]
                                localSource.removeAll()
                                if wt.image != ""
                                {
                                    localSource.append(AlamofireSource(urlString: wt.image, placeholder: UIImage(named: "placeholder.jpg")))
                                }
                                if wt.imageFile != ""
                                {
                                    localSource.append(AlamofireSource(urlString: wt.imageFile, placeholder: UIImage(named: "placeholder")))
                                }
                                if wt.imgAdditional1 != ""
                                {
                                    localSource.append(AlamofireSource(urlString: wt.imgAdditional1, placeholder: UIImage(named: "placeholder")))
                                }
                                if wt.imgAdditional2 != ""
                                {
                                    localSource.append(AlamofireSource(urlString: wt.imgAdditional2, placeholder: UIImage(named: "placeholder")))
                                }
                                                               
                                self.vwSlidImage.setImageInputs(localSource as! [InputSource])
                               // self.imgProduct.sd_setImage(with: URL(string: wt.image), placeholderImage: UIImage(named: "placeholder.png"))
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
extension SellDetailVC //api upload photo
{
    func uploadPhoto(selectedImage:UIImage)
    {
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)

        let parameter = ["PurchaseID":self.producrDetai.purchaseID]
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 100
        configuration.timeoutIntervalForResource = 100
        
        alamoFireManager = Alamofire.Session(configuration: configuration)
        alamoFireManager!.upload(multipartFormData: { multipartFormData in
            
            let mugImgData = selectedImage.jpegData(compressionQuality: 0.2)!
            multipartFormData.append(mugImgData, withName: "WatchPhoto",fileName: "WatchPhoto.jpg", mimeType: "image/jpg")
            
            for (key, value) in parameter {
                multipartFormData.append(((value).data(using: String.Encoding.utf8)!), withName: key)
            }
        },
                                 to: Constants.Server.baseUrl+"/JewelleryApi/UpdateWatchImage", usingThreshold: UInt64.init(), method: .post, headers: [:]).responseJSON{(response) in
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
                                self.imgProduct.image = selectedImage
                                self.present(ActionHandler.showAlert(message: msg), animated: true, completion: nil)
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
extension SellDetailVC:editWatchDelegate
{
    func successEdit(productID: String) {
        self.productID = productID
        self.getStockDetail()
    }
}
