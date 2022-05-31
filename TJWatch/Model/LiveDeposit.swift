//
//  LiveDeposit.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 31/01/2022.
//

import Foundation
import SwiftyJSON

class LiveDeposit:NSObject
{
     init(liveDepositID: String, clientName: String, make: String, model: String, year: String, price: String, advancePayment: String, remainingPayment: String, isSold: String, serialNo: String, material: String, size: String, dial: String, clientID: String, clientContactNo: String, clientEmail: String, totalPrice: String)
    {
        self.liveDepositID = liveDepositID
        self.clientName = clientName
        self.make = make
        self.model = model
        self.year = year
        self.price = price
        self.advancePayment = advancePayment
        self.remainingPayment = remainingPayment
        self.isSold = isSold
        self.serialNo = serialNo
        self.material = material
        self.size = size
        self.dial = dial
        self.clientID = clientID
        self.clientContactNo = clientContactNo
        self.clientEmail = clientEmail
        self.totalPrice = totalPrice
    }
    
    var liveDepositID:String
    var clientName:String
    var make:String
    var model:String
    var year:String
    var price:String
    var advancePayment:String
    var remainingPayment:String
    var isSold:String
    var serialNo:String
    var material:String
    var size:String
    var dial:String
    var clientID:String
    var clientContactNo:String
    var clientEmail:String
    var totalPrice:String
    
    static func fromJSON(_ json:[String: Any]) -> LiveDeposit {
        let json = JSON(json)
        let liveDepositID = json["liveDepositID"].stringValue
        let clientName = json["clientName"].stringValue
        let make = json["make"].stringValue
        let model = json["model"].stringValue
        let year = json["year"].stringValue
        let price = json["price"].stringValue
        let advancePayment = json["advancePayment"].stringValue
        let remainingPayment = json["remainingPayment"].stringValue
        let isSold = json["isSold"].stringValue
        let serialNo = json["serialNo"].stringValue
        let material = json["material"].stringValue
        let size = json["size"].stringValue
        let dial = json["dial"].stringValue
        let clientID = json["clientID"].stringValue
        let clientContactNo = json["clientContactNo"].stringValue
        let clientEmail = json["clientEmail"].stringValue
        let totalPrice = json["totalPrice"].stringValue
        
        return LiveDeposit(liveDepositID: liveDepositID, clientName: clientName, make: make, model: model, year: year, price: price, advancePayment: advancePayment, remainingPayment: remainingPayment, isSold: isSold, serialNo: serialNo, material: material, size: size, dial: dial, clientID: clientID, clientContactNo: clientContactNo, clientEmail: clientEmail, totalPrice: totalPrice)
    }
}

