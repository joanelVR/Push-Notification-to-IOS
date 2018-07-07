//
//  ViewController.swift
//  PushNotificationExample
//
//  Created by Joanel Vasquez on 7/6/18.
//  Copyright © 2018 infosys. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //For sending local notifications you need three objects: The Content, The Trigger and The Request
        
        //1- Content
        let content = UNMutableNotificationContent()
        content.title = "Local Notification"
        content.body = "Infosys rul3z"
        content.sound = UNNotificationSound.default()
        
        //2- Trigger
        /*
         There are three types of triggers:
         1- UNCalendarNotificationTrigger: Can be used to specify date and time for the notification.
         2- UNLocationNotificationTrigger: Can be used to specify the location (when the user enters the region, the notification will be fired)
         3- UNTimeIntervalNotificationTrigger: Can be used to specfy the amount of time for the notification (timeInterval in seconds)
         */
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        //3- Request
        // The identifier is used to identify the notification. If another notification with the same identifier is send, then the first notification gets overriden by the new notification).
        let request = UNNotificationRequest(identifier: "testIdentifier", content: content, trigger: trigger)
        
        //Sends the notfication
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
