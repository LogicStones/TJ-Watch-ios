//
//  AppDelegate.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 22/12/2021.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import LocalAuthentication

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        IQKeyboardManager.shared.enable = true
        let data = UserLogin.getFrmUD()
        FirebaseApp.configure()
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        
        if data.id != ""
        {
            SharedManager.sharedInstance.userData = data
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Identify yourself!"
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                    [weak self] success, authenticationError in
                    
                    DispatchQueue.main.async {
                        if success {
                            let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "tabbarVC") as! UITabBarController
                            vw.selectedIndex = 0
                            let root = UINavigationController.init(rootViewController: vw)
                            root.navigationBar.isHidden = true
                            self!.window?.rootViewController = root
                            self!.window?.makeKeyAndVisible()
                            
                        }
                        else
                        {
                            
                        }
                    }
                }
            }
            else
            {
                let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "tabbarVC") as! UITabBarController
                vw.selectedIndex = 0
                let root = UINavigationController.init(rootViewController: vw)
                root.navigationBar.isHidden = true
                self.window?.rootViewController = root
                self.window?.makeKeyAndVisible()
            }
            
        }
        else
        {
            DispatchQueue.main.async
            {
                let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginVC")
                let root = UINavigationController.init(rootViewController: vw)
                root.navigationBar.isHidden = true
                self.window?.rootViewController = root
                self.window?.makeKeyAndVisible()
            }
        }
        return true
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        
        //  let dataDict:[String: String] = ["token": fcmToken ]
        Constants.tokens.deviceToken = fcmToken!
        let data = UserLogin.getFrmUD()
        if data.id != ""
        {
            updateDeivceToken(UserId: data.id, DeviceToken: fcmToken!) { response in
             print(response)
            }
        }
    }
}

extension AppDelegate:  UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print(userInfo)
        
        completionHandler([[.banner, .sound]])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        var notifType = ""
        var linkUrl = ""
        if let info = userInfo as? [String:Any]
        {
            if let key = info["gcm.notification.messageKey"] as? String
            {
                notifType = key
            }
            if let url = info["gcm.notification.urllink"] as? String
            {
                linkUrl = url
            }
        }
        let data = UserLogin.getFrmUD()
        if data.id != ""
        {
            if notifType == "buy"
            {
                let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "tabbarVC") as! UITabBarController
                vw.selectedIndex = 2
                let nav = UINavigationController.init(rootViewController: vw)
                nav.isNavigationBarHidden = true
                self.window?.rootViewController = nav
                self.window?.makeKeyAndVisible()
                //UIApplication.shared.windows.first?.rootViewController = nav
                // UIApplication.shared.windows.first?.makeKeyAndVisible()
            }
            else if notifType == "verify"
            {
                // print(data)
                if let url = URL(string: linkUrl), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }
            else
            {
                let topvw = UIApplication.getTopMostViewController()
                let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SoldListVC") as! SoldListVC
                topvw?.navigationController?.pushViewController(vw, animated: true)
            }
        }
        else
        {
            let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginVC")
            let root = UINavigationController.init(rootViewController: vw)
            root.navigationBar.isHidden = true
            self.window?.rootViewController = root
            self.window?.makeKeyAndVisible()
            // UIApplication.shared.windows.first?.rootViewController = root
            // UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
        completionHandler()
    }
}
extension UIApplication {
    class func getTopMostViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopMostViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopMostViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopMostViewController(base: presented)
        }
        return base
    }
}
