//
//  AppDelegate.swift
//  PushNotificationExample
//
//  Created by Joanel Vasquez on 7/6/18.
//  Copyright © 2018 infosys. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    
    //STEP 4- The device hands the token over to the app. The following two methods need to be implemented for STEP 4
    //To be call if the registration was successful. It's called every time the app gets started
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("token:\(token)")
    }
    //To be called if the registration wasn't successful
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    
    /*STEP 5- The app sends the device token to the back end.
       - The back end needs a push certificate in order to recognize the APNS.
       - Here we sent the token to the server side, so it all depends on the implementation of the backend
     
      There is something you have to consider:
        The callback for receiving the device token will be called every time the app gets started. In most cases, the device token doesn’t change – it’s possible though that it does! So your backend has to have some kind of service for updating the device token.    */
    
    //Implemented method. This method is used so that the notification will be displayed when the app is in the foreground.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
    
    //Implemented method. This method allows to have the notification perform some kind of action
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.notification.request.identifier == "testIdentifier" {
            print("handling notification with the identifier 'testIdentifier'")
        }
        
        if let notification = response.notification.request.content.userInfo as? [String:AnyObject] {
            let message = parseRemoteNotification(notification: notification)
            print(message as Any)
        }
        
        completionHandler()
    }
    
    //Function to parse the notifications
    private func parseRemoteNotification(notification:[String:AnyObject]) -> String? {
        if let aps = notification["aps"] as? [String:AnyObject] {
            let alert = aps["alert"] as? String
            return alert;
        }
        
        return nil
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        UNUserNotificationCenter.current().delegate = self;
        
        /*
         This methods triggers an alert view, which ask the user whether they allows the app to send notification
         Parameters:
         - 1st parameter is an array of options which indicate the type of notifications to be send (alerts, badge indicationr and sounds).
         - 2nd parameter is block that is called after the user has responded after the alert view.
         */
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            print("granted: \(granted)")
        }
        
        //STEP 1- The app requests to get registered for push notifications
        UIApplication.shared.registerForRemoteNotifications()
        
        /*
         STEP 2 (The device hands the request over to the APNS) &
         STEP 3 (The APNS sends a device token) are taken care off in the background
        */
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}
