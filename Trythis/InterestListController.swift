//
//  ViewController.swift
//  Trythis
//
//  Created by user136320 on 12/9/19.
//  Copyright © 2019 user136320. All rights reserved.
//

import UIKit

class InterestListController: UIViewController, UITableViewDataSource, TrythisView {
    
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
    
    // DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return interests.keys.count
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
                cell.interest = interest
                cell.view = self
                cell.lblNameSubcategory.text = interest.subcategory
                cell.swInterest.isOn = interest.interest
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
    // View
    
    func updated() {
        interests = presenter!.getInterests()
        self.tableView.reloadData()
    }
    
    func changeValue(interest: Interest) {
        presenter?.changeInterest(interest)
    }
}

