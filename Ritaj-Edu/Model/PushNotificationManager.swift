//
//  PushNotificationManager.swift
//  Ritaj-Edu
//
//  Created by tarek bahie on 7/1/20.
//  Copyright © 2020 tarek bahie. All rights reserved.
//

import Firebase
import FirebaseMessaging
import UIKit
import UserNotifications
class PushNotificationManager: NSObject, MessagingDelegate, UNUserNotificationCenterDelegate {
    let userID: String
    let gcmMessageIDKey = "gcm.message_id"
    init(userID: String) {
        self.userID = userID
        super.init()
    }
    func registerForPushNotifications() {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            // For iOS 10 data message (sent via FCM)
            
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        UIApplication.shared.registerForRemoteNotifications()
        updateFirestorePushTokenIfNeeded()
    }
    func updateFirestorePushTokenIfNeeded() {
        if let token = Messaging.messaging().fcmToken {
            switch userID {
            case "1@2.om":
                let ref = db.collection("Teachers").document(userID)
                ref.setData(["fcmToken":token], merge: true)
                return
            case "3@4.com":
                let ref = db.collection("Teachers").document(userID)
                ref.setData(["fcmToken":token], merge: true)
                return
            case "5@6.com":
                let ref = db.collection("Teachers").document(userID)
                ref.setData(["fcmToken":token], merge: true)
                return
            default:
                let ref = db.collection("Students").document(userID)
                ref.setData(["fcmToken":token], merge: true)
            }
        }
    }
     func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
           print("Received data message: \(remoteMessage.appData)")
       }

       func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
           print(response)
       }

       func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
           if let messageID = userInfo[gcmMessageIDKey] {
               print("Message ID: \(messageID)")
           }

           print(userInfo)
       }

       func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
           print("Unable to register for remote notifications: \(error.localizedDescription)")
       }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print(fcmToken)
    }
}
