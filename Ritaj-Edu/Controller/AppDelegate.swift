//
//  AppDelegate.swift
//  Ritaj-Edu
//
//  Created by tarek bahie on 3/2/20.
//  Copyright © 2020 tarek bahie. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        FirebaseApp.configure()
        let tabCntrl = UITabBarController()
        let first = AboutVC()
        if #available(iOS 13.0, *) {
            first.view.backgroundColor = .systemBackground
        } else {
            first.view.backgroundColor = .white
        }
        first.title = "About"
        first.isNavigationBarHidden = true
        if #available(iOS 13.0, *) {
            first.tabBarItem.image = UIImage(systemName: "info.circle")
        } else {
            first.tabBarItem.image = UIImage(named: "info")
        }
        let second = UINavigationController(rootViewController: LoginOrRegisterVC())
        second.navigationItem.backBarButtonItem?.isEnabled = true
        if #available(iOS 13.0, *) {
            second.view.backgroundColor = .systemBackground
        } else {
            second.view.backgroundColor = .white
        }
        second.title = "Account"
        if #available(iOS 13.0, *) {
            second.tabBarItem.image = UIImage(systemName: "person")
        } else {
            second.tabBarItem.image = UIImage(named: "person")
        }
        let third = DataCollectionVC()
        if #available(iOS 13.0, *) {
            third.view.backgroundColor = .systemBackground
        } else {
            third.view.backgroundColor = .white
        }
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
        return true
    }



}

