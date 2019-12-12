//
//  EventListController.swift
//  Trythis
//
//  Created by user136320 on 12/11/19.
//  Copyright © 2019 user136320. All rights reserved.
//

import UIKit

class EventListController: UIViewController, UITableViewDataSource, UITableViewDelegate, TrythisView {
    
    @IBOutlet var tableView: UITableView!
    //@IBOutlet var progress: UIActivityIndicatorView!
    
    var events: Array<Event> = []
    var presenter: TrythisPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = TrythisPresenter(view: (self as? TrythisView)!)
        self.title = "Eventos"
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        presenter!.fetchEvents()
        self.events = presenter!.getEvents()
    }
    
    func updated() {
        events = presenter!.getEvents()
        self.tableView.reloadData()    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = self.events[indexPath.row]
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "event", for: indexPath) as? EventCell {
            cell.lblName.text = event.name
            cell.lblDate.text = event.date
//            let url = "https://image.tmdb.org/t/p/w154" + movie.url_image
//            cell.imgMovie.sd_setImage(with: URL(string: url))
            return cell
        }
        return UITableViewCell()
    }
/*
    @IBAction func changeType(_ sender: UISegmentedControl) {
        let idx = sender.selectedSegmentIndex
        if idx == 0 {
            currentListing = POPULAR_MOVIE_LISTING
            self.movies = presenter!.getMoviesPopular()
        } else {
            currentListing = FAVORITE_MOVIE_LISTING
            self.movies = presenter!.getMoviesFavorite()
        }
        self.tableView.reloadData()
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailMovie" {
            if let vc = segue.destination as? MovieShowController {
                vc.movie = sender as? Movie
                vc.presenter = presenter!
            }
        }
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let linha = indexPath.row
        let movie = self.movies[linha]
        if currentListing == POPULAR_MOVIE_LISTING {
            movie.favorite = presenter!.getMoviesFavorite().contains { movieList in
                return movieList.id == movie.id
            }
        }
        performSegue(withIdentifier: "goToDetailMovie", sender: movie)
    }*/
}
