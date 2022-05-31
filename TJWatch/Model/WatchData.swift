//
//  WatchData.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 23/12/2021.
//

import Foundation
import SwiftyJSON

class WatchData:NSObject
{
    var purchaseID:String
    var make:String
    var model:String
    var subModel:String
    var customisation:String
    var size:String
    var dial:String
    var salePrice:String
    var watchYear:String
    var purchasePrice:String
    var descrption:String
    var image:String
    var ukWatchNo:String
    var serialNo:String
    var userName:String
    var material:String
    var paperWork:String
    var servicePapers:String
    var box:String
    var makeID:String
    var purchaseDate:String
    
    var imageFile:String
    var imgAdditional1File:String
    var imgAdditional1:String
    var imgAdditional2File:String
    var imgAdditional2:String
    var sellerName:String
    var pdfUrl:String
    
    init(purchaseID: String, make: String, model: String, subModel: String, customisation:String, size: String, dial: String, salePrice: String, watchYear: String, purchasePrice: String, descrption: String, image: String, ukWatchNo: String, serialNo: String, userName: String, material:String,paperWork:String,servicePapers:String,box:String,makeID:String, purchaseDate:String, imageFile:String, imgAdditional1File:String, imgAdditional1:String, imgAdditional2File:String, imgAdditional2:String,sellerName:String, pdfUrl:String)
    {
        self.purchaseID = purchaseID
        self.make = make
        self.model = model
        self.subModel = subModel
        self.customisation = customisation
        self.size = size
        self.dial = dial
        self.salePrice = salePrice
        self.watchYear = watchYear
        self.purchasePrice = purchasePrice
        self.descrption = descrption
        self.image = image
        self.ukWatchNo = ukWatchNo
        self.serialNo = serialNo
        self.userName = userName
        self.material = material
        self.paperWork = paperWork
        self.servicePapers = servicePapers
        self.box = box
        self.makeID = makeID
        self.purchaseDate = purchaseDate
        self.imageFile = imageFile
        self.imgAdditional1File = imgAdditional1File
        self.imgAdditional1 = imgAdditional1
        self.imgAdditional2File = imgAdditional2File
        self.imgAdditional2 = imgAdditional2
        self.sellerName = sellerName
        self.pdfUrl = pdfUrl
        
    }
    
    static func fromJSON(_ json:[String: Any]) -> WatchData {
        let json = JSON(json)
        let purchaseID = json["purchaseID"].stringValue
        let make = json["make"].stringValue
        let model = json["model"].stringValue
        let subModel = json["subModel"].stringValue
        let customisation = json["customisation"].stringValue
        let size = json["size"].stringValue
        let dial = json["dial"].stringValue
        let salePrice = json["salePrice"].stringValue
        let watchYear = json["watchYear"].stringValue
        let purchasePrice = json["purchasePrice"].stringValue
        let descrption = json["description"].stringValue
        let image = json["image"].stringValue
        let ukWatchNo = json["ukWatchNo"].stringValue
        let serialNo = json["serialNo"].stringValue
        let userName = json["userName"].stringValue
        let material = json["material"].stringValue
        let paperWork = json["paperWork"].stringValue
        let servicePapers = json["servicePapers"].stringValue
        let box = json["box"].stringValue
        let makeID = json["makeID"].stringValue
        let purchaseDate = json["purchaseDate"].stringValue
        let imageFile = json["imageFile"].stringValue
        let imgAdditional1File = json["imgAdditional1File"].stringValue
        let imgAdditional1 = json["imgAdditional1"].stringValue
        let imgAdditional2File = json["imgAdditional2File"].stringValue
        let imgAdditional2 = json["imgAdditional2"].stringValue
        let sellerName = json["sellerName"].stringValue
        let pdfUrl = json["pdfUrl"].stringValue
        
        return WatchData(purchaseID: purchaseID, make: make, model: model, subModel: subModel, customisation: customisation, size: size, dial: dial, salePrice: salePrice, watchYear: watchYear, purchasePrice: purchasePrice, descrption: descrption, image: image, ukWatchNo: ukWatchNo, serialNo: serialNo, userName: userName,material: material,paperWork:paperWork,servicePapers: servicePapers,box:box,makeID: makeID, purchaseDate: purchaseDate, imageFile: imageFile, imgAdditional1File: imgAdditional1File, imgAdditional1:imgAdditional1, imgAdditional2File:imgAdditional2File, imgAdditional2:imgAdditional2, sellerName:sellerName, pdfUrl: pdfUrl)
    }
}
