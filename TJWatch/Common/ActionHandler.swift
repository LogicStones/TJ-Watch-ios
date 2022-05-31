//
//  ActionHandler.swift
//  DawgTales
//
//  Created by Abubakar on 31/03/2020.
//  Copyright © 2020 LS. All rights reserved.
//

import Foundation
import UIKit
//import iProgressHUD

class ActionHandler: NSObject {
    static func showAlert(message:String)-> UIAlertController
    {        let alert = UIAlertController(title: "Alert!", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        alert.view.tintColor = UIColor.black
        return alert
    }
    
    static func showAlertPopViewController(message:String, vw:UIViewController)-> UIAlertController
    {        let alert = UIAlertController(title: "Alert!", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (at) in
            vw.navigationController?.popViewController(animated: false)
        }))
        alert.view.tintColor = UIColor.black
        return alert
    }
    
    static func showAlertDismisViewController(message:String, vw:UIViewController)-> UIAlertController
    {        let alert = UIAlertController(title: "Alert!", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (at) in
            vw.dismiss(animated: true, completion: nil)
        }))
        alert.view.tintColor = UIColor.black
        return alert
    }
    
    static func showAlertPushViewController(message:String, vwParent:UIViewController, moveVW:UIViewController)-> UIAlertController
    {        let alert = UIAlertController(title: "Alert!", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (at) in
            vwParent.navigationController?.pushViewController(moveVW, animated: false)
        }))
        alert.view.tintColor = UIColor.black
        return alert
    }
    
    static func statusBar() -> UIView  {
        guard let statusBarView = UIApplication.shared.value(forKeyPath: "statusBarWindow") as? UIView else {
                return UIView()
            }
        let statusBarColor = UIColor(red: 52/255, green: 52/255, blue: 52/255, alpha: 1.0)
        statusBarView.backgroundColor = statusBarColor
        return statusBarView
    }
    static func isValidEmail(emailText:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailText)
    }

    static func stBoard(name:String)->UIStoryboard
    {
        let st = UIStoryboard.init(name: name, bundle: nil)
        return st
    }
    static func delUpdateUserDefaultsForUserData(uData:UserLogin){
        UserDefaults.standard.removeObject(forKey: "LoginUserData")
        let dt = try! NSKeyedArchiver.archivedData(withRootObject: uData, requiringSecureCoding: false)
        UserDefaults.standard.set(dt, forKey: "LoginUserData")
    }
    static func logoutUser()
    {
        SharedManager.sharedInstance.userData = nil
        UserDefaults.standard.removeObject(forKey: "LoginUserData")
        UserDefaults.standard.synchronize()
    }
    static func getTimeZoneInMinutes()->String
    {
        let tz = TimeZone.current.secondsFromGMT()
        let tzM = tz / 60
        return (tzM as NSNumber).stringValue
    }
    static func DoubleWithFraction(numberOFValue:Int, value:Double)-> String
    {
       return String(format: "%\(numberOFValue)f", value)
    }
    
   static func addComma(amount:String)->String
    {
        if amount != ""
        {
            let largeNumber = Int(amount.replacingOccurrences(of: ",", with: "").replacingOccurrences(of: ".", with: ""))
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let formattedNumber = numberFormatter.string(from: NSNumber(value:largeNumber!))
            return formattedNumber!
        }
        else
        {
            return "0"
        }
    }
}

extension UIView
{
    func topCornerRadius(radius:Float)
    {
        clipsToBounds = true
        layer.cornerRadius = CGFloat(radius)
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    func bottomCornerRadius(radius:Float)
    {
        clipsToBounds = true
        layer.cornerRadius = CGFloat(radius)
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    func topBottomLeftCornerRadius(radius:Float)
    {
        clipsToBounds = true
        layer.cornerRadius = CGFloat(radius)
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    func topBottomRightCornerRadius(radius:Float)
    {
        clipsToBounds = true
        layer.cornerRadius = CGFloat(radius)
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
//    func dropShadow(scale: Bool = true, opacity:Float, radius: Int) {
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = opacity
//        layer.shadowOffset = CGSize.zero
//        layer.shadowRadius = CGFloat(radius)
//    }
    func dropShadowView(scale: Bool = true) {
       layer.masksToBounds = false
       layer.shadowColor = UIColor.black.cgColor
       layer.shadowOpacity = 0.3
       layer.shadowOffset = CGSize(width: -1, height: 1)
       layer.shadowRadius = 2
    }
    func dropShadowView(opacity:Float,shadowRadius:Float)
    {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = CGFloat(shadowRadius)
    }
    func vwBorderRadius(color:UIColor,bordrWidth:Int,radius:Float)
    {
        vwaddBordr(color: color, bordrWidth: bordrWidth)
        vwCornerRadius(radius: radius)
    }
    func vwaddBordr(color:UIColor,bordrWidth:Int)
    {
        layer.borderWidth = CGFloat(bordrWidth)
        layer.borderColor = color.cgColor
    }
    func vwCornerRadius(radius:Float)
    {
        layer.cornerRadius = CGFloat(radius)
        clipsToBounds = true
    }
}

extension UIButton
{
      func btnShadow() {
        layer.shadowColor = UIColor.black.cgColor
         self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
         self.layer.shadowOpacity = 0.5;
         self.layer.shadowRadius = 1.0;
    }
}
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func stringByAppendingPathComponent(path: String) -> String {
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(path)
    }
}
extension UIImageView
{
    func setImgTintColor(colr:UIColor) {
        self.image = self.image!.withRenderingMode(.alwaysTemplate)
        self.tintColor = colr
    }
}
extension UIButton
{
    func setBorder()
    {
        layer.borderWidth = 1.5
        layer.borderColor = Constants.appColors.appGrayColor.cgColor
        
    }
}
extension UILabel
{
    func setCircular(){
        
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.size.width/2.0;
        }
    }
}
extension UITextField
{
    func setBrdBg()
    {
        layer.borderColor = Constants.appColors.txtBrdClr.cgColor
        layer.borderWidth = 1.0
        //layer.backgroundColor = UIColor.green.cgColor
        backgroundColor = .clear
        textColor = UIColor.black
        layer.cornerRadius = 18
        clipsToBounds = true
    }
    func changePlaceHolderTextColor(text:String)
    {
        attributedPlaceholder = NSAttributedString(string: text,
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 67/255, green: 67/255, blue: 67/255, alpha: 1.0)])
    }
   // self.autocapitalizationType = .allCharacters
}
