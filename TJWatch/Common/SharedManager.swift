//
//  SharedManager.swift
//  CanTaxi
//
//  Created by Abubakar on 13/09/2018.
//  Copyright © 2018 Abubakar. All rights reserved.
//

import Foundation

class SharedManager: NSObject {
    private override init() { }
    static let sharedInstance = SharedManager()
    
    var userData:UserLogin!
    
}
