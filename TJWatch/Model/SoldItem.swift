//
//  SoldItem.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 31/12/2021.
//

import Foundation
import SwiftyJSON
import SideMenu

class SoldItem:NSObject
{
    init(saleID: String, ukWatchNo: String, watchName: String, serialNo: String, descrption: String, year: String, soldPrice: String, img: String, soldDateTime: String, buyerName: String, buyerPhone: String, buyerEmail: String, invoiceURL: String, soldDate: String, model:String) {
        self.saleID = saleID
        self.ukWatchNo = ukWatchNo
        self.watchName = watchName
        self.serialNo = serialNo
        self.descrption = descrption
        self.year = year
        self.soldPrice = soldPrice
        self.img = img
        self.soldDateTime = soldDateTime
        self.buyerName = buyerName
        self.buyerPhone = buyerPhone
        self.buyerEmail = buyerEmail
        self.invoiceURL = invoiceURL
        self.soldDate = soldDate
        self.model = model
    }
    
    var saleID:String
    var ukWatchNo:String
    var watchName:String
    var serialNo:String
    var descrption:String
    var year:String
    var soldPrice:String
    var img:String
    var soldDateTime:String
    var buyerName:String
    var buyerPhone:String
    var buyerEmail:String
    var invoiceURL:String
    var soldDate:String
    var model:String
    
    static func fromJSON(_ json:[String: Any]) -> SoldItem {
        let json = JSON(json)
        let saleID = json["saleID"].stringValue
        let ukWatchNo = json["ukWatchNo"].stringValue
        let watchName = json["watchName"].stringValue
        let serialNo = json["serialNo"].stringValue
        let descrption = json["description"].stringValue
        let year = json["year"].stringValue
        let soldPrice = json["soldPrice"].stringValue
        let img = json["img"].stringValue
        let soldDateTime = json["soldDateTime"].stringValue
        let buyerName = json["buyerName"].stringValue
        let buyerPhone = json["buyerPhone"].stringValue
        let buyerEmail = json["buyerEmail"].stringValue
        let invoiceURL = json["invoiceURL"].stringValue
        let soldDate = json["soldDate"].stringValue
        let model = json["model"].stringValue
        
        return SoldItem(saleID: saleID, ukWatchNo: ukWatchNo, watchName: watchName, serialNo: serialNo, descrption: descrption, year: year, soldPrice: soldPrice, img: img, soldDateTime: soldDateTime, buyerName: buyerName, buyerPhone: buyerPhone, buyerEmail: buyerEmail, invoiceURL: invoiceURL, soldDate: soldDate, model: model)
    }
    
}
