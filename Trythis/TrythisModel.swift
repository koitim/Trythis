//
//  EventModel.swift
//  Trythis
//
//  Created by user136320 on 12/11/19.
//  Copyright © 2019 user136320. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class TrythisModel {
    
    var presenter: TrythisPresenter?
    
    func setPresenter(_ presenter: TrythisPresenter) {
        self.presenter = presenter
    }
    
/*    class func getMoviesPopular(_ callback: @escaping (_ movies: Array<Movie>?, _ error: Error?) -> Void) {
        let http = URLSession.shared
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=942ccf9bf53c7651369a6116da7ed318&language=pt-BR")
        let request = URLRequest(url: url!)
        let task = http.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if let error = error {
                callback(nil, error)
                return
            }
            if let data = data {
                let movies = MovieService.parserJson(data)
                DispatchQueue.main.async {
                    callback(movies, nil)
                }
            }
        })
        task.resume()
    }
    
    class func favorite(_ movie: Movie) {
        let currentUser = Auth.auth().currentUser
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref
            .child("favoritos")
            .child(currentUser!.uid)
            .child(String(movie.id))
            .setValue(movie.cloneFirebase())
    }
    
    class func unFavorite(_ movie: Movie) {
        let currentUser = Auth.auth().currentUser
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref
            .child("favoritos")
            .child(currentUser!.uid)
            .child(String(movie.id))
            .removeValue()
     }*/
    
    func getEvents(_ callback: @escaping (_ events: Array<Event>?, _ error: Error?) -> Void) {
        //let currentUser = Auth.auth().currentUser
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("EVENTOS").observeSingleEvent(of: .value, with: {(snapshot) in
            var events: Array<Event> = []
            for child in snapshot.children {
                let data = child as! DataSnapshot
                let dataValue = data.value as! [String: AnyObject]
                let event = Event()
                //event.name = dataValue["name"] as! String
                event.name = data.key
                event.date = dataValue["date"] as! String
                event.category = dataValue["category"] as! String
                event.subcategory = dataValue["subcategory"] as! String
                events.append(event)
            }
            DispatchQueue.main.async {
                callback(events, nil)
            }
        }) {(error) in
            callback(nil, error)
        }
    }
    
    func getCategories(_ callback: @escaping (_ interests: Array<Interest>?, _ error: Error?) -> Void) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("CATEGORIAS").observeSingleEvent(of: .value, with: {(snapshot) in
            var interests: Array<Interest> = []
            for child in snapshot.children {
                let data = child as! DataSnapshot
                let interest = Interest()
                interest.category = data.key
                interests.append(interest)
                let dataValue = data.value as! [String: AnyObject]
                for element in dataValue {
                    let interest = Interest()
                    interest.category = data.key
                    interest.subcategory = element.key
                    interests.append(interest)
                }
            }
            DispatchQueue.main.async {
                callback(interests, nil)
            }
        }) {(error) in
            callback(nil, error)
        }
    }
    
    func getInterests(_ callback: @escaping (_ interests: Array<Interest>?, _ error: Error?) -> Void) {
        let currentUser = Auth.auth().currentUser
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("INTERESTS").child(currentUser!.uid).observeSingleEvent(of: .value, with: {(snapshot) in
            var interests: Array<Interest> = []
            for child in snapshot.children {
                let data = child as! DataSnapshot
                let dataValue = data.value as! [String: AnyObject]
                for element in dataValue {
                    let interest = Interest()
                    interest.category = data.key
                    interest.subcategory = element.key
                    interests.append(interest)
                }
            }
            DispatchQueue.main.async {
                callback(interests, nil)
            }
        }) {(error) in
            callback(nil, error)
        }
    }
    /*
    class func parserJson(_ data: Data) -> Array<Event> {
        var events: Array<Event> = []
        do {
            let dictResponse = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary
            let arrayMovies = dictResponse["results"] as! NSArray
            for obj in arrayMovies {
                let dict = obj as! NSDictionary
                let movie = Movie()
                movie.id = dict["id"] as! Int
                movie.title = getValue("title", dict)
                movie.synopsis = getValue("overview", dict)
                movie.url_image = getValue("poster_path", dict)
                movies.append(movie)
            }
        } catch let error as NSError {
            print("Erro ao ler JSON (error)")
        }
        return movies
    }
    
    class func getValue(_ key: String, _ dict: NSDictionary) -> String {
        let s = dict[key]
        if let s = s {
            return s as! String
        }
        return ""
    }*/
    
}
