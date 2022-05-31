//
//  LoginVC.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 22/12/2021.
//

import UIKit
import RappleProgressHUD
import LocalAuthentication


class LoginVC: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.txtUsername.setBrdBg()
        self.txtPassword.setBrdBg()
        
        self.btnLogin.vwCornerRadius(radius: 22)
        self.btnLogin.addTarget(self, action: #selector(self.loginUser), for: .touchUpInside)
    }
    
    @objc private func loginUser()
    {
        if self.txtUsername.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Enter username"), animated: true, completion: nil)
            return
        }
        if self.txtUsername.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Enter password"), animated: true, completion: nil)
            return
        }
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
        loginSer(UserName: self.txtUsername.text!, UserPassword: self.txtPassword.text!, DeviceId: Constants.tokens.deviceToken) { response in
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
                                self.present(ActionHandler.showAlert(message: msg), animated: true, completion: nil)
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
                                let user = UserLogin.fromJSON(dt)
                                SharedManager.sharedInstance.userData = user
                                UserLogin.saveInUD(uData: user)
                                ActionHandler.delUpdateUserDefaultsForUserData(uData: user)
                                RappleActivityIndicatorView.stopAnimation()
                                let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "tabbarVC") as? UITabBarController
                                vw?.selectedIndex = 0
                                self.navigationController?.pushViewController(vw!, animated: true)
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
