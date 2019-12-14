//
//  MoviePresenter.swift
//  Trythis
//
//  Created by user136320 on 12/11/19.
//  Copyright © 2019 user136320. All rights reserved.
//

import UIKit
import UserNotifications

class TrythisPresenter {
    
    static private var instance: TrythisPresenter? = nil
    
    var events: Array<Event> = []
    var interests = [String:[Interest]]()
    var firstTime = true
    
    var view: TrythisView? = nil
    let model: TrythisModel
    
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    class func shared() -> TrythisPresenter {
        //if guard instance = instance {
        if instance == nil {
            instance = TrythisPresenter()
        }
        return instance!
    }
    
    init() {
        self.model = TrythisModel()
        model.setPresenter(self)
    }
    
    func setView(_ view: TrythisView) {
        self.view = view
    }
    
    func getEvents() -> Array<Event> {
        return events
    }
    
    func fetchEvents() {
        let cbListener = {(_ events: Array<Event>?, _ error: Error?) -> Void in
            if let newEvents = events {
                if self.firstTime {
                    self.firstTime = false
                } else {
                    for event in newEvents {
                        if !(self.events.contains{
                            $0.name == event.name
                        }) {
                            for interest in self.interests[event.category]! {
                                if interest.subcategory == event.subcategory &&
                                    interest.interest {
                                    self.appDelegate?.scheduleNotification(text: event.name)
                                }
                            }
                        }
                    }
                }
                self.events = newEvents
                self.view?.updated()
            }
        }
        model.addListenerEvents(cbListener)
    }
    
    func getInterests() -> [String: [Interest]] {
        return interests
    }
    
    func fetchInterests() {
        let cbInterests = {(_ interests: [String:[Interest]]?, _ error: Error?) -> Void in
            if let interestsUser = interests {
                for (category,listInterests) in interestsUser {
                    for interest in listInterests {
                        let subcategory = interest.subcategory
                        for element in self.interests[category]! {
                            if element.subcategory == subcategory {
                                element.interest = true
                                break
                            }
                        }
                    }
                }
                self.view?.updated()
            }
        }
        let cbCategories = {(_ categories: [String:[Interest]]?, _ error: Error?) -> Void in
            if let categories = categories {
                self.interests = categories
                self.view?.updated()
                self.model.getInterests(cbInterests)
            }
        }
        model.getCategories(cbCategories)
    }
    
    func changeInterest(_ interest: Interest) {
        if interest.interest {
            model.addInterest(interest)
        } else {
            model.removeInterest(interest)
        }
    }
}
