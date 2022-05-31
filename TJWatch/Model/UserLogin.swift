//
//  UserLogin.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 23/12/2021.
//

import Foundation
import SwiftyJSON

class UserLogin: NSObject,NSCoding {
    var id:String
    var name:String
    var image:String
    var imageUrl:String
    var email:String
    var rememberMe:String
    var isAdmin:String
    
    init(id:String,name:String,image:String,imageUrl:String,email:String,rememberMe:String,isAdmin:String)
    {
        self.id = id
        self.name = name
        self.image = image
        self.imageUrl = imageUrl
        self.email = email
        self.rememberMe = rememberMe
        self.isAdmin = isAdmin
    }
    
    required  init? (coder aDecoder: NSCoder)
    {
        self.id = aDecoder.decodeObject(forKey: "id") as! String
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.image = aDecoder.decodeObject(forKey: "image") as! String
        self.imageUrl = aDecoder.decodeObject(forKey: "imageUrl") as! String
        self.email = aDecoder.decodeObject(forKey: "email") as! String
        self.rememberMe = aDecoder.decodeObject(forKey: "rememberMe") as! String
        self.isAdmin = aDecoder.decodeObject(forKey: "isAdmin") as! String
    }
    
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(image, forKey: "image" )
        aCoder.encode(imageUrl, forKey: "imageUrl")
        aCoder.encode(email, forKey: "email" )
        aCoder.encode(rememberMe, forKey: "rememberMe")
        aCoder.encode(isAdmin, forKey: "isAdmin")
    }
    
    static func fromJSON(_ json:[String: Any]) -> UserLogin
    {
        let json = JSON(json)
        let id = json["id"].stringValue
        let name = json["name"].stringValue
        let image = json["image"].stringValue
        let imageUrl = json["imageUrl"].stringValue
        let email = json["email"].stringValue
        let rememberMe = json["rememberMe"].stringValue
        let isAdmin = json["isAdmin"].stringValue
        
        return UserLogin(id: id, name: name, image: image, imageUrl: imageUrl, email: email, rememberMe: rememberMe, isAdmin: isAdmin)
    }
    
    static func saveInUD(uData:UserLogin)
    {
       let ud =  UserDefaults.standard
        ud.setValue(uData.id, forKey: "id")
        ud.setValue(uData.name, forKey: "name")
        ud.setValue(uData.image, forKey: "image")
        ud.setValue(uData.imageUrl, forKey: "imageUrl")
        ud.setValue(uData.email, forKey: "email")
        ud.setValue(uData.rememberMe, forKey: "rememberMe")
        ud.setValue(uData.isAdmin, forKey: "isAdmin")
        ud.synchronize()
    }
    
    static func getFrmUD()->UserLogin
    {
        let ud = UserDefaults.standard
        guard ud.string(forKey: "id") != nil else {
            return UserLogin(id: "", name: "", image: "", imageUrl: "", email: "", rememberMe: "", isAdmin: "")
        }
        let id = ud.string(forKey: "id")
        let name = ud.string(forKey: "name")
        let image = ud.string(forKey: "image")
        let imageUrl = ud.string(forKey: "imageUrl")
        let email = ud.string(forKey: "email")
        let rememberMe = ud.string(forKey: "rememberMe")
        let isAdmin = ud.string(forKey: "isAdmin")
        
        return UserLogin(id: id!, name: name!, image: image!, imageUrl: imageUrl!, email: email!, rememberMe: rememberMe!, isAdmin: isAdmin!)
    }
    
    static func removeFromUD()
    {
        let ud = UserDefaults.standard
        ud.removeObject(forKey: "id")
        ud.removeObject(forKey: "name")
        ud.removeObject(forKey: "image")
        ud.removeObject(forKey: "imageUrl")
        ud.removeObject(forKey: "email")
        ud.removeObject(forKey: "rememberMe")
        ud.removeObject(forKey: "isAdmin")
    }
}
