//
//  ViewController.swift
//  Trythis
//
//  Created by user136320 on 12/9/19.
//  Copyright © 2019 user136320. All rights reserved.
//

import UIKit

class InterestListController: UIViewController, UITableViewDataSource, UITableViewDelegate, TrythisView {
    
    @IBOutlet var tableView: UITableView!
    //@IBOutlet var progress: UIActivityIndicatorView!
    
    var interests = [String: [Interest]]()
    var presenter: TrythisPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = TrythisPresenter(view: (self as? TrythisView)!)
        self.title = "Interesses"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        presenter!.fetchInterests()
        self.interests = presenter!.getInterests()
    }
    
    @IBAction func changeInterest(_ sender: UISwitch) {
        let interest = Interest()
        interest.category = "Shows"
        interest.subcategory = "MPB"
        interest.interest = sender.isOn
        presenter?.changeInterest(interest)
        /*if let category = sender.value(forUndefinedKey: "category") as? String, let subcategory = sender.value(forUndefinedKey: "subcategory") as? String {
            let interest = Interest()
            interest.category = category
            interest.subcategory = subcategory
            interest.interest = sender.isOn
            presenter?.changeInterest(interest)
        }*/
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return interests.keys.count
    }
    
    func updated() {
        interests = presenter!.getInterests()
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let keys = interests.keys.sorted()
        return keys[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keys = interests.keys.sorted()
        let key = keys[section]
        if let listInterests = interests[key] {
            return listInterests.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let keys = interests.keys.sorted()
        let key = keys[indexPath.section]
        if let listInterests = interests[key] {
            let interest = listInterests[indexPath.row]
            if let cell = tableView.dequeueReusableCell(withIdentifier: "Interest", for: indexPath) as? SubcategoryCell {
                cell.lblNameSubcategory.text = interest.subcategory
                cell.swInterest.isOn = interest.interest
                
                //cell.swInterest.setValue(key, forUndefinedKey: "category")
                //cell.swInterest.setValue(interest.subcategory, forUndefinedKey: "subcategory")
                return cell
            }
        }
        return UITableViewCell()
    }
}

