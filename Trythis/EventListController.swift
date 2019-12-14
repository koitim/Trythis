//
//  EventListController.swift
//  Trythis
//
//  Created by user136320 on 12/11/19.
//  Copyright © 2019 user136320. All rights reserved.
//

import UIKit

class EventListController: UIViewController, UITableViewDataSource, TrythisView {
    
    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet var progress: UIActivityIndicatorView!
    
    var events: Array<Event> = []
    var presenter: TrythisPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = TrythisPresenter.shared()
        self.title = "Eventos"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        presenter!.fetchEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.setView(self)
    }
    
    
    // View
    
    func updated() {
        events = presenter!.getEvents()
        self.tableView.reloadData()
    }
    
    func changeValue(interest: Interest) {
        
    }
    
    
    // DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = self.events[indexPath.row]
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "Event", for: indexPath) as? EventCell {
            cell.lblName.text = event.name
            cell.lblDate.text = event.date
            return cell
        }
        return UITableViewCell()
    }
}
