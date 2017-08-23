//
//  KeyperObjects.swift
//  Keyper
//
//  Created by Prathamesh Vaidya on 07/08/17.
//  Copyright © 2017 Prathamesh Vaidya. All rights reserved.
//

import Foundation
import RealmSwift

class Account: Object {
    dynamic var accID = UUID().uuidString
    dynamic var masterInd = false
    dynamic var title = ""
    dynamic var uname = ""
    dynamic var email = ""
    dynamic var mob = ""
    dynamic var password = ""
    dynamic var socialLogin:Account? = nil
    
    override static func primaryKey() -> String? {
        return "accID"
    }
}
