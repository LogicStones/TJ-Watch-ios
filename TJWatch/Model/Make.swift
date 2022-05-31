//
//  Make.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 23/12/2021.
//

import Foundation
import SwiftyJSON

class WatchMake:NSObject
{
    var id:String
    var name:String
    var make:String
    var total:String
    var logo:String
    
    
    init(id: String, name: String, make:String,total:String, logo:String) {
        self.id = id
        self.name = name
        self.make = make
        self.total = total
        self.logo = logo
    }
    
    static func fromJSON(_ json:[String: Any]) -> WatchMake {
        let json = JSON(json)
        let id = json["id"].stringValue
        let name = json["name"].stringValue
        let make = json["make"].stringValue
        let total = json["total"].stringValue
        let logo = json["logo"].stringValue
        
        return WatchMake(id: id, name: name, make: make, total: total, logo:logo)
    }
}
