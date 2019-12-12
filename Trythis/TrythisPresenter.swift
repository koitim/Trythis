//
//  MoviePresenter.swift
//  Trythis
//
//  Created by user136320 on 12/11/19.
//  Copyright © 2019 user136320. All rights reserved.
//

import UIKit

class TrythisPresenter {
    var events: Array<Event> = []
    var interests: Array<Interest> = []
    
    let view: TrythisView
    let model: TrythisModel
    
    init(view: TrythisView) {
        self.view = view
        self.model = TrythisModel()
        model.setPresenter(self)
    }
    
    func getEvents() -> Array<Event> {
        return events
    }
    
    func fetchEvents() {
        let callback = {(_ events: Array<Event>?, _ error: Error?) -> Void in
            if let events = events {
                self.events = events
                self.view.updated()
            }
        }
        model.getEvents(callback)
    }
    
    func getInterests() -> Array<Interest> {
        return interests
    }
    
    func fetchInterests() {
        let cbInterests = {(_ interests: Array<Interest>?, _ error: Error?) -> Void in
            if let interestsUser = interests {
                for interestUser in interestsUser {
                    for interest in self.interests {
                        if interest.category == interestUser.category &&
                            interest.subcategory == interestUser.subcategory {
                            interest.interest = true
                        }
                    }
                }
                self.view.updated()
            }
        }
        let cbCategories = {(_ categories: Array<Interest>?, _ error: Error?) -> Void in
            if let categories = categories {
                self.interests = categories
                self.view.updated()
                self.model.getInterests(cbInterests)
            }
        }
        model.getCategories(cbCategories)
    }
    /*
    func favorite(_ movie: Movie) {
        MovieService.favorite(movie)
        moviesFavorites.append(movie)
        view.updatedFavorites()
    }
    
    func unFavorite(_ movie: Movie) {
        MovieService.unFavorite(movie)
        moviesFavorites = moviesFavorites.filter { (m) -> Bool in
            movie.id != m.id
        }
        view.updatedFavorites()
    }*/
}
