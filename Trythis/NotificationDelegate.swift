//
//  NotificationDelegate.swift
//  Trythis
//
//  Created by posgrad on 14/12/2019.
//  Copyright © 2019 user136320. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func userRequest() {
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
    }
    
    func scheduleNotification(text: String) {
        
        let content = UNMutableNotificationContent()
        let userActions = "User Actions"
        
        content.title = "Novo evento do seu interesse!"
        content.body = text
        content.sound = UNNotificationSound.default()
        content.badge = 1
        content.categoryIdentifier = userActions
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)
        
        let identifier = "Local Notification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        
        let eventAction = UNNotificationAction(identifier: "Event", title: "Novo evento", options: [])
        let category = UNNotificationCategory(identifier: userActions,
                                              actions: [eventAction],
                                              intentIdentifiers: [],
                                              options: [])
        
        notificationCenter.setNotificationCategories([category])
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert,.sound])
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.notification.request.identifier == "Local Notification" {
            print("Handling notifications with the Local Notification Identifier")
        }
        
        switch response.actionIdentifier {
            case UNNotificationDismissActionIdentifier:
                print("Dismiss Action")
            case UNNotificationDefaultActionIdentifier:
                print("Default")
            case "Event":
                print("Event")
                scheduleNotification(text: "sdfd")
            default:
                print("Unknown action")
        }
        completionHandler()
    }
}
