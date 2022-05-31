//
//  Notification.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 04/02/2022.
//

import Foundation
import SwiftyJSON

class Notification:NSObject
{
    init(id: String, title: String, descrption: String, productID: String, userID: String, orderID: String, insertedDT: String, verificationID: String, isBroadCasted: String, fcmResult: String, type: String, link: String) {
        self.id = id
        self.title = title
        self.descrption = descrption
        self.productID = productID
        self.userID = userID
        self.orderID = orderID
        self.insertedDT = insertedDT
        self.verificationID = verificationID
        self.isBroadCasted = isBroadCasted
        self.fcmResult = fcmResult
        self.type = type
        self.link = link
    }
    
    var id:String
    var title:String
    var descrption:String
    var productID:String
    var userID:String
    var orderID:String
    var insertedDT:String
    var verificationID:String
    var isBroadCasted:String
    var fcmResult:String
    var type:String
    var link:String
    
    
    static func fromJSON(_ json:[String: Any]) -> Notification {
        let json = JSON(json)
        let id = json["id"].stringValue
        let title = json["title"].stringValue
        let descrption = json["description"].stringValue
        let productID = json["productID"].stringValue
        let userID = json["userID"].stringValue
        let orderID = json["orderID"].stringValue
        let insertedDT = json["insertedDT"].stringValue
        let verificationID = json["verificationID"].stringValue
        let isBroadCasted = json["isBroadCasted"].stringValue
        let fcmResult = json["fcmResult"].stringValue
        let type = json["type"].stringValue
        let link = json["link"].stringValue
        
        return Notification(id: id, title: title, descrption: descrption, productID: productID, userID: userID, orderID: orderID, insertedDT: insertedDT, verificationID: verificationID, isBroadCasted: isBroadCasted, fcmResult: fcmResult, type: type, link: link)
        
    }
}
