//
//  ServiceList.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 30/12/2021.
//

import Foundation
import SwiftyJSON

class ServiceList:NSObject
{
    init(serviceID: String, make: String, model: String, serialNo: String, descrption: String, serviceCharges: String, typeOfProblem: String, advance: String, image: String, receiveDT: String, returnDT: String, serviceStatus: String, custName: String, contactNo: String, email: String, firstName: String, userName: String, userID: String, balPayment: String, advancePayType:String,clientId:String, advAdditionalImage:String, makeID:String, cash:String, card:String, imgCard:String, wire:String, crypto:String, imgCardFile:String, imgWire:String, imgWireFile:String, imgCrypto:String, imgCryptoFile:String, watchImg:String,watchFile:String)
    {
        self.serviceID = serviceID
        self.make = make
        self.model = model
        self.serialNo = serialNo
        self.descrption = descrption
        self.serviceCharges = serviceCharges
        self.typeOfProblem = typeOfProblem
        self.advance = advance
        self.image = image
        self.receiveDT = receiveDT
        self.returnDT = returnDT
        self.serviceStatus = serviceStatus
        self.custName = custName
        self.contactNo = contactNo
        self.email = email
        self.firstName = firstName
        self.userName = userName
        self.userID = userID
        self.balPayment = balPayment
        self.advancePayType = advancePayType
        self.clientId = clientId
        self.advAdditionalImage = advAdditionalImage
        self.makeID = makeID
        self.cash = cash
        self.card = card
        self.imgCard = imgCard
        self.wire = wire
        self.crypto = crypto
        self.imgCardFile = imgCardFile
        self.imgWire = imgWire
        self.imgWireFile = imgWireFile
        self.imgCrypto = imgCrypto
        self.imgCryptoFile = imgCryptoFile
        self.watchImg = watchImg
        self.watchFile = watchFile
    }
    
    var serviceID:String
    var make:String
    var model:String
    var serialNo:String
    var descrption:String
    var serviceCharges:String
    var typeOfProblem:String
    var advance:String
    var image:String
    var receiveDT:String
    var returnDT:String
    var serviceStatus:String
    var custName:String
    var contactNo:String
    var email:String
    var firstName:String
    var userName:String
    var userID:String
    var balPayment:String
    var advancePayType:String
    
    var clientId:String
    var advAdditionalImage:String
    var makeID:String
    var cash:String
    var card:String
    var imgCard:String
    var wire:String
    var crypto:String
    var imgCardFile:String
    var imgWire:String
    var imgWireFile:String
    var imgCrypto:String
    var imgCryptoFile:String
    var watchImg:String
    var watchFile:String
    
    
    static func fromJSON(_ json:[String: Any]) -> ServiceList {
        let json = JSON(json)
        let serviceID = json["serviceID"].stringValue
        let make = json["make"].stringValue
        let model = json["model"].stringValue
        let serialNo = json["serialNo"].stringValue
        let descrption = json["description"].stringValue
        let serviceCharges = json["serviceCharges"].stringValue
        let typeOfProblem = json["typeOfProblem"].stringValue
        let advance = json["advance"].stringValue
        let image = json["image"].stringValue
        let serviceStatus = json["serviceStatus"].stringValue
        let receiveDT = json["receiveDT"].stringValue
        let returnDT = json["returnDT"].stringValue
        let custName = json["custName"].stringValue
        let contactNo = json["contactNo"].stringValue
        let email = json["email"].stringValue
        let firstName = json["firstName"].stringValue
        let userName = json["userName"].stringValue
        let userID = json["userID"].stringValue
        let balPayment = json["balPayment"].stringValue
        let advancePayType = json["advancePayType"].stringValue
        let clientId = json["clientId"].stringValue
        let advAdditionalImage = json["advAdditionalImage"].stringValue
        let makeID = json["makeID"].stringValue
        let cash = json["cash"].stringValue
        let card = json["card"].stringValue
        let imgCard = json["imgCard"].stringValue
        let wire = json["wire"].stringValue
        let crypto = json["crypto"].stringValue
        let imgCardFile = json["imgCardFile"].stringValue
        let imgWire = json["imgWire"].stringValue
        let imgWireFile = json["imgWireFile"].stringValue
        let imgCrypto = json["imgCrypto"].stringValue
        let imgCryptoFile = json["imgCryptoFile"].stringValue
        let watchImg = json["watchImg"].stringValue
        let watchFile = json["watchFile"].stringValue
        
        return ServiceList(serviceID: serviceID, make: make, model: model, serialNo: serialNo, descrption: descrption, serviceCharges: serviceCharges, typeOfProblem: typeOfProblem, advance: advance, image: image, receiveDT: receiveDT, returnDT: returnDT, serviceStatus: serviceStatus, custName: custName, contactNo: contactNo, email: email, firstName: firstName, userName: userName, userID: userID, balPayment: balPayment,advancePayType: advancePayType,clientId:clientId, advAdditionalImage: advAdditionalImage, makeID: makeID, cash: cash, card: card, imgCard: imgCard, wire: wire,  crypto:crypto, imgCardFile:imgCardFile, imgWire: imgWire, imgWireFile: imgWireFile, imgCrypto: imgCrypto, imgCryptoFile: imgCryptoFile, watchImg:watchImg, watchFile: watchFile)
        
    }
    
}
