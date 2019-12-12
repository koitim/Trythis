//
//  Interest.swift
//  Trythis
//
//  Created by user136320 on 12/11/19.
//  Copyright © 2019 user136320. All rights reserved.
//

import Foundation

class Interest {
    
    var category = " "
    var subcategory = " "
    var interest = false
    
    func isCategory() -> Bool {
        return subcategory == " "
    }
    
    func isSubcategory() -> Bool {
        return subcategory != " "
    }
}
