//
//  Subcategory.swift
//  Trythis
//
//  Created by user136320 on 12/11/19.
//  Copyright © 2019 user136320. All rights reserved.
//

import UIKit

class SubcategoryCell: UITableViewCell {
    
    var interest: Interest? = nil
    var view: TrythisView? = nil
    
    @IBOutlet weak var lblNameSubcategory: UILabel!
    @IBOutlet weak var swInterest: UISwitch!
    
    @IBAction func changeInterest(_ sender: UISwitch) {
        interest?.interest = sender.isOn
        view?.changeValue(interest: interest!)
    }
    
}
