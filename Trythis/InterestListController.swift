//
//  ViewController.swift
//  Trythis
//
//  Created by user136320 on 12/9/19.
//  Copyright © 2019 user136320. All rights reserved.
//

import UIKit

class InterestListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    //@IBOutlet var progress: UIActivityIndicatorView!
    
    var interests: Array<Interest> = []
    var presenter: TrythisPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = TrythisPresenter(view: (self as? TrythisView)!)
        self.title = "Interesses"
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        presenter!.fetchInterests()
        self.interests = presenter!.getInterests()
    }
    
    func updated() {
        interests = presenter!.getInterests()
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let interest = self.interests[indexPath.row]
        if interest.isCategory() {
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: "interest", for: indexPath) as? CategoryCell {
                cell.lblNameCategory.text = interest.category
                return cell
            }
        } else {
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: "interest", for: indexPath) as? SubcategoryCell {
                cell.lblNameSubcategory.text = interest.subcategory
                cell.swInterest.isOn = interest.interest
                return cell
            }
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

