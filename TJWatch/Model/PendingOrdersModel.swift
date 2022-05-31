//
//  PendingOrders.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 26/01/2022.
//

import Foundation
import SwiftyJSON

class PendingOrdersModel:NSObject
{
     init(id: String, clientName: String, make: String, model: String, year: String, price: String, advPayment: String, balance: String, purchaseId: String,pendingOrderID:String, serialNo:String, material:String, size:String, dial:String, clientID:String, clientContactNo:String, clientEmail:String, totalPrice:String, advancePayment:String,remainingPayment:String)
    {
        self.id = id
        self.clientName = clientName
        self.make = make
        self.model = model
        self.year = year
        self.price = price
        self.advPayment = advPayment
        self.balance = balance
        self.purchaseId = purchaseId
        self.pendingOrderID = pendingOrderID
        self.serialNo = serialNo
        self.material = material
        self.size = size
        self.dial = dial
        self.clientID = clientID
        self.clientContactNo = clientContactNo
        self.clientEmail = clientEmail
        self.totalPrice = totalPrice
        self.advancePayment = advancePayment
        self.remainingPayment = remainingPayment
    }
    
    var id:String
    var clientName:String
    var make:String
    var model:String
    var year:String
    var price:String
    var advPayment:String
    var balance:String
    var purchaseId:String
    
    var pendingOrderID:String
    var serialNo:String
    var material:String
    var size:String
    var dial:String
    var clientID:String
    var clientContactNo:String
    var clientEmail:String
    var totalPrice:String
    var advancePayment:String
    var remainingPayment:String
    
    
    static func fromJSON(_ json:[String: Any]) -> PendingOrdersModel {
        let json = JSON(json)
        let id = json["id"].stringValue
        let clientName = json["clientName"].stringValue
        let make = json["make"].stringValue
        let model = json["model"].stringValue
        let year = json["year"].stringValue
        let price = json["price"].stringValue
        let advPayment = json["advPayment"].stringValue
        let balance = json["balance"].stringValue
        let purchaseId = json["purchaseId"].stringValue
        let pendingOrderID = json["pendingOrderID"].stringValue
        let serialNo = json["serialNo"].stringValue
        let material = json["material"].stringValue
        let size = json["size"].stringValue
        let dial = json["dial"].stringValue
        let clientID = json["clientID"].stringValue
        let clientContactNo = json["clientContactNo"].stringValue
        let clientEmail = json["clientEmail"].stringValue
        let totalPrice = json["totalPrice"].stringValue
        let advancePayment = json["advancePayment"].stringValue
        let remainingPayment = json["remainingPayment"].stringValue
        
        return PendingOrdersModel(id: id, clientName: clientName, make: make, model: model, year: year, price: price, advPayment: advPayment, balance: balance, purchaseId: purchaseId, pendingOrderID: pendingOrderID, serialNo: serialNo, material: material, size: size, dial: dial, clientID: clientID, clientContactNo: clientContactNo, clientEmail: clientEmail, totalPrice: totalPrice, advancePayment: advancePayment, remainingPayment: remainingPayment)
}
}
