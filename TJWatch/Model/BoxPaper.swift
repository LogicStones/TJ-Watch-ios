//
//  File.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 04/01/2022.
//

import Foundation
import SwiftyJSON

class BoxPaper:NSObject
{
    init(disabled: String, group: String, selected: String, text: String, value: String) {
        self.disabled = disabled
        self.group = group
        self.selected = selected
        self.text = text
        self.value = value
    }
    
    var disabled:String
    var group:String
    var selected:String
    var text:String
    var value:String
    
    static func fromJSON(_ json:[String: Any]) -> BoxPaper
    {
        let json = JSON(json)
        let disabled = json["disabled"].stringValue
        let group = json["group"].stringValue
        let selected = json["selected"].stringValue
        let text = json["text"].stringValue
        let value = json["value"].stringValue
        
        return BoxPaper(disabled: disabled, group: group, selected: selected, text: text, value: value)
    }
}
