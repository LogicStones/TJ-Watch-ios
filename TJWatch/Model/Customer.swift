//
//  Customer.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 04/01/2022.
//

import Foundation
import SwiftyJSON

class Customer:NSObject
{
    init(id: String, name: String, Sharjeel: String, phone: String, email: String, proofIdImg: String, proofAddressImg: String)
    {
        self.id = id
        self.name = name
        self.Sharjeel = Sharjeel
        self.phone = phone
        self.email = email
        self.proofIdImg = proofIdImg
        self.proofAddressImg = proofAddressImg
    }
    
    var id:String
    var name:String
    var Sharjeel:String
    var phone:String
    var email:String
    var proofIdImg:String
    var proofAddressImg:String
    
    static func fromJSON(_ json:[String: Any]) -> Customer
    {
        let json = JSON(json)
        let id = json["id"].stringValue
        let name = json["name"].stringValue
        let Sharjeel = json["Sharjeel"].stringValue
        let phone = json["phone"].stringValue
        let email = json["email"].stringValue
        let proofIdImg = json["proofIdImg"].stringValue
        let proofAddressImg = json["proofAddressImg"].stringValue
        
        return Customer(id: id, name: name, Sharjeel: Sharjeel, phone: phone, email: email, proofIdImg: proofIdImg, proofAddressImg: proofAddressImg)
    }
}
