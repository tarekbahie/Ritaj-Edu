//
//  AppDelegate.swift
//  Ritaj-Edu
//
//  Created by tarek bahie on 3/2/20.
//  Copyright © 2020 tarek bahie. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

let savedSatData = UserDefaults.standard
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,MessagingDelegate {

    var window : UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        FirebaseApp.configure()
        let tabCntrl = UITabBarController()
        UITabBar.appearance().tintColor = UIColor(named: "retajGreen")
        UINavigationBar.appearance().tintColor = UIColor(named: "retajGreen")
        UITabBar.appearance().isTranslucent = false
        UINavigationBar.appearance().isTranslucent = false
        let first = UINavigationController(rootViewController: AboutVC())
            first.view.backgroundColor = UIColor(named: "retajGreen")
        first.title = "About"
        if #available(iOS 13.0, *) {
            first.tabBarItem.image = UIImage(systemName: "info.circle")
        } else {
            first.tabBarItem.image = UIImage(named: "info")
        }
        let second = UINavigationController(rootViewController: LoginOrRegisterVC())
        second.navigationItem.backBarButtonItem?.isEnabled = true
        second.view.backgroundColor = UIColor(named: "retajGreen")
        second.title = "Account"
        if #available(iOS 13.0, *) {
            second.tabBarItem.image = UIImage(systemName: "person")
        } else {
            second.tabBarItem.image = UIImage(named: "person")
        }
        let third = UINavigationController(rootViewController: DataCollectionVC())
        third.view.backgroundColor = UIColor(named: "retajGreen")
        third.title = "Data"
        if #available(iOS 13.0, *) {
            third.tabBarItem.image = UIImage(systemName: "list.bullet")
        } else {
            third.tabBarItem.image = UIImage(named: "list")
        }
        tabCntrl.viewControllers = [first,second,third]
        window?.rootViewController = tabCntrl
        window?.makeKeyAndVisible()
        let db = Firestore.firestore()
        UIApplication.shared.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
            // If granted comes true you can enabled features based on authorization.
            guard granted else { return }
            DispatchQueue.main.async {
                if let e = Auth.auth().currentUser?.email{
                    let pushManager = PushNotificationManager(userID: e)
                    pushManager.registerForPushNotifications()
                }
            }
        }

        UNUserNotificationCenter.current().delegate = self
        return true
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
           print("Unable to register for remote notifications: \(error.localizedDescription)")
       }

       func application(_ application: UIApplication,didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
           Messaging.messaging().apnsToken = deviceToken as Data

       }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        // Print full message.
        print(userInfo)

    }
}
