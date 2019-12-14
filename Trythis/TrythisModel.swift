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
    
    func addInterest(_ interest: Interest) {
        let currentUser = Auth.auth().currentUser
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref
            .child("INTERESTS")
            .child(currentUser!.uid)
            //.child("CATEGORIES")
            .child(interest.category)
            .child(interest.subcategory)
            .setValue(interest.subcategory)
    }
    
    func removeInterest(_ interest: Interest) {
        let currentUser = Auth.auth().currentUser
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref
            .child("INTERESTS")
            .child(currentUser!.uid)
            //.child("CATEGORIES")
            .child(interest.category)
            .child(interest.subcategory)
            .removeValue()
     }
    
    func getEvents(_ callback: @escaping (_ events: Array<Event>?, _ error: Error?) -> Void) {
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
    
    func getCategories(_ callback: @escaping (_ interests: [String:[Interest]]?, _ error: Error?) -> Void) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("CATEGORIAS").observeSingleEvent(of: .value, with: {(snapshot) in
            var mapInterests = [String:[Interest]]()
            for child in snapshot.children {
                let data = child as! DataSnapshot
                var interests: [Interest] = []
                let dataValue = data.value as! [String: AnyObject]
                for element in dataValue {
                    let interest = Interest()
                    interest.category = data.key
                    interest.subcategory = element.key
                    interests.append(interest)
                }
                mapInterests[data.key] = interests
            }
            DispatchQueue.main.async {
                callback(mapInterests, nil)
            }
        }) {(error) in
            callback(nil, error)
        }
    }
    
    func getInterests(_ callback: @escaping (_ interests: [String:[Interest]]?, _ error: Error?) -> Void) {
        let currentUser = Auth.auth().currentUser
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("INTERESTS").child(currentUser!.uid).observeSingleEvent(of: .value, with: {(snapshot) in
            var mapInterests = [String:[Interest]]()
            for child in snapshot.children {
                let data = child as! DataSnapshot
                var interests: [Interest] = []
                let dataValue = data.value as! [String: AnyObject]
                for element in dataValue {
                    let interest = Interest()
                    interest.category = data.key
                    interest.subcategory = element.key
                    interests.append(interest)
                }
                mapInterests[data.key] = interests
            }
            DispatchQueue.main.async {
                callback(mapInterests, nil)
            }
        }) {(error) in
            callback(nil, error)
        }
    }
}
