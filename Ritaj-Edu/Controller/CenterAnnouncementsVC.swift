//
//  CenterAnnouncementsVC.swift
//  Ritaj-Edu
//
//  Created by tarek bahie on 3/3/20.
//  Copyright © 2020 tarek bahie. All rights reserved.
//

import UIKit
import Firebase
class CenterAnnouncementsVC: UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,UICollectionViewDelegate {
    lazy var collectionView : UICollectionView = {
        let lay = UICollectionViewFlowLayout()
        let cView = UICollectionView(frame: .zero, collectionViewLayout: lay)
        cView.dataSource = self
        cView.delegate = self
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.backgroundColor = UIColor(named: "retajGreen")
        return cView
    }()
    var subjToShow:[String]?
    var msgToshow:[String]?{
        didSet{
            showNotifications()
        }
    }
    var size:String?
    var courses:[String]?{
        didSet{
            for ind in 0..<courses!.count - 1{
                if courses![ind] == ""{
                    courses?.remove(at: ind)
                }
            }
            collectionView.reloadData()
        }
    }
    var allNotifications=[String](){
        didSet{
            print(allNotifications)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(NotifCell.self, forCellWithReuseIdentifier: "notifCell")
        if #available(iOS 13.0, *) {
            view.backgroundColor = UIColor(named: "retajGreen")
        } else {
            view.backgroundColor = UIColor(named: "retajGreen")
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        size = DataService.instance.size
        setupViews()
        getRegisteredCourses()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return m.count
        if let c = courses{
            return c.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "notifCell", for: indexPath) as! NotifCell
            cell.configCellForAdmin(subj: courses?[indexPath.item] ?? "", msg: "", size: size)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: view.safeAreaLayoutGuide.layoutFrame.height / 4)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            getCourseNotifications(courseName: courses?[indexPath.item] ?? "")
    }
    func setupViews(){
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    func getRegisteredCourses(){
        guard let email = Auth.auth().currentUser?.email else{return}
        DataService.instance.getRegisteredCourses(email: email) { (registeredCourses) in
            self.courses = registeredCourses
            self.courses?.insert("Admin", at: 0)
        }
    }
    func getCourseNotifications(courseName:String){
        if courseName != "" {
            if courseName == "Admin"{
                getNotifsFromAdmin()
            }else{
                DataService.instance.getStudentsNotificationsFromTeacherWith(name: courseName) { (notifs) in
                self.msgToshow = notifs
                    print(notifs)
                    }
            }
        }
    }
    func getNotifsFromAdmin(){
        DataService.instance.getStudentsNotificationsFromAdmin { (subjs, msgs) in
            self.subjToShow = subjs
            self.msgToshow = msgs
            print(subjs,msgs)
        }
    }
    func showNotifications(){
        guard let sub = subjToShow else{
            guard let msg = msgToshow else{return}
            if !msg.isEmpty{
                let notifVC = NotificationsVC()
                notifVC.modalPresentationStyle = .fullScreen
                notifVC.m = msg
                self.msgToshow = nil
                navigationController?.pushViewController(notifVC, animated: true)
            }
            return
        }
        if let msg = msgToshow{
            if !msg.isEmpty{
                let notifVC = NotificationsVC()
                notifVC.modalPresentationStyle = .fullScreen
                notifVC.subject = sub
                notifVC.m = msg
                self.subjToShow = nil
                self.msgToshow = nil
                navigationController?.pushViewController(notifVC, animated: true)
            }
        }
    }
}
