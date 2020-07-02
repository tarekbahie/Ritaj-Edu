//
//  PushNotificationSender.swift
//  Ritaj-Edu
//
//  Created by tarek bahie on 7/1/20.
//  Copyright © 2020 tarek bahie. All rights reserved.
//

import UIKit
class PushNotificationSender {
    func sendPushNotification(to token: String, title: String, body: String) {
        let urlString = "https://fcm.googleapis.com/fcm/send"
        let url = NSURL(string: urlString)!
        let paramString: [String : Any] = ["to" : token,
                                           "notification" : ["title" : title, "body" : body],
                                           "priority" : "high"
        ]
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject:paramString, options: [.prettyPrinted])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=AAAAY3tfKsE:APA91bEfDsyEJcg_-YwCiMgjg66qLcLBgTpRk0-jt5Q90mr7lD6u6vRh_o4RgyTsA9BvgmjMKxXvbnIZY9JJoV634WcOYOo6BqyqcEd5nKTyaoNSL3lS4ANRtwQUWw67Upi3H60ubTUS", forHTTPHeaderField: "Authorization")
        let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
            do {
                if let jsonData = data {
                    if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                        NSLog("Received data:\n\(jsonDataDict))")
                    }
                }
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
        task.resume()
    }
}
