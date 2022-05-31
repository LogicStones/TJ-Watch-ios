//
//  Salesman.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 02/02/2022.
//

import Foundation
import SwiftyJSON

class Salesman:NSObject
{
    init(image: String, userName: String, totalSale: String, soldProduct: String,firstName:String, lastName:String, phone:String, email:String,id:String)
    {
        self.image = image
        self.userName = userName
        self.totalSale = totalSale
        self.soldProduct = soldProduct
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.email = email
        self.id = id
    }
    
    var image:String
    var userName:String
    var totalSale:String
    var soldProduct:String
    var firstName:String
    var lastName:String
    var phone:String
    var email:String
    var id:String
    
    static func fromJSON(_ json:[String: Any]) -> Salesman {
        let json = JSON(json)
        let image = json["image"].stringValue
        let userName = json["userName"].stringValue
        let totalSale = json["totalSale"].stringValue
        let soldProduct = json["soldProduct"].stringValue
        let firstName = json["firstName"].stringValue
        let lastName = json["lastName"].stringValue
        let phone = json["phone"].stringValue
        let email = json["email"].stringValue
        let id = json["id"].stringValue
        
        return Salesman(image: image, userName: userName, totalSale: totalSale, soldProduct: soldProduct, firstName:firstName, lastName: lastName, phone: phone, email: email, id: id)
    }
}
