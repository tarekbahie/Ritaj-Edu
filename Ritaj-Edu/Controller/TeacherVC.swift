//
//  TeacherVC.swift
//  Ritaj-Edu
//
//  Created by tarek bahie on 6/29/20.
//  Copyright © 2020 tarek bahie. All rights reserved.
//

import UIKit
import Firebase
class TeacherVC:UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,UICollectionViewDelegate{

    lazy var collectionView : UICollectionView = {
        let lay = UICollectionViewFlowLayout()
        let cView = UICollectionView(frame: .zero, collectionViewLayout: lay)
        cView.dataSource = self
        cView.delegate = self
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.backgroundColor = UIColor(named: "retajGreen")
        return cView
    }()
    let sendNewNotif:UIButton={
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor(named: "retajBlue")
        return btn
    }()
    var n = [String]()
    var a = [String]()
    var sN = [String]()
    var sG = [String]()
    var mob = [String]()
    var emails = [String]()
    var tokensForNotifs=[String]()
    var payments:[String]?{
        didSet{
            collectionView.reloadData()
        }
    }
    var canRemoveComposeView:Bool?{
        didSet{
            view.viewWithTag(1000)?.removeFromSuperview()
        }
    }
    var errorSendingNotif:Bool?{
        didSet{
            view.viewWithTag(1000)?.removeFromSuperview()
            showAlert(msg: "Please check the data again", title: "Error Sending")
        }
    }
    var notifMsg: String?{
        didSet{
            if notifMsg != "" {
                sendNewNotifToStudents()
            }
        }
    }
    var size:String?
    var currentEmailSignedIn:String?{
        didSet{
            handleTeacherName()
        }
    }
    var teacherName:String?{
        didSet{
            getStudentData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(StudentCell.self, forCellWithReuseIdentifier: "studentCell")
        sendNewNotif.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        view.backgroundColor = UIColor(named: "retajGreen")
    }
    fileprivate func getStudentData() {
        guard let tName = teacherName else{return}
        DataService.instance.getStudentsForTeachersWith(name: tName) { (names, ages, sNames, sGrades, mobiles, emails, payments,tokens) in
            self.n = names
            self.a = ages
            self.sN = sNames
            self.sG = sGrades
            self.mob = mobiles
            self.emails = emails
            self.tokensForNotifs = tokens
            self.payments = payments
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupViews()
        setupFontSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        n.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "studentCell", for: indexPath) as! StudentCell
        cell.configureCellForTeachers(name: n[indexPath.item], age: a[indexPath.item], sName: sN[indexPath.item], sGrade: sG[indexPath.item], mob: mob[indexPath.item], mail: emails[indexPath.item], payments: self.payments?[indexPath.item] ?? "Not paid", size: size)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: view.safeAreaLayoutGuide.layoutFrame.height/4)
    }
    func setupViews(){
        view.addSubview(collectionView)
        view.addSubview(sendNewNotif)
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: sendNewNotif.topAnchor,constant: -10).isActive = true
        
        sendNewNotif.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -5).isActive = true
        sendNewNotif.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10).isActive = true
        sendNewNotif.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10).isActive = true
        sendNewNotif.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    @objc func handleSend(){
        let composeView = ComposeTeacherMsgView()
        composeView.home = self
        composeView.tag = 1000
        self.addView(compView: composeView)
    }
    func sendNewNotifToStudents(){
        guard let msg = notifMsg, let tName = teacherName else{return}
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy HH:mm:ss"
        let date = Date()
        let res = formatter.string(from: date)
        let time = formatter.date(from: res)
        let stamp = Timestamp(date: time!)
        DataService.instance.sendTeacherNotifications(teacherName: tName, notif: msg, time: stamp) { (success, err) in
            if let error = err{
                self.showAlert(msg: error, title: "Error sending message")
            }else{
                self.showAlert(msg: "Message Sent", title: "Success")
                self.sendPushNotifToStudents(title: tName, body: msg)
            }
        }
    }
    func sendPushNotifToStudents(title:String,body:String){
        if !tokensForNotifs.isEmpty{
            for t in tokensForNotifs{
                if t != ""{
                    let sender = PushNotificationSender()
                    sender.sendPushNotification(to: t, title: title, body: body)
                }
            }
        }
    }
    func showAlert(msg:String,title:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func addView(compView:ComposeTeacherMsgView){
        compView.layer.cornerRadius = 12.0
        compView.layer.masksToBounds = true
        compView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(compView)
        compView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        compView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        compView.widthAnchor.constraint(equalToConstant: (self.view.safeAreaLayoutGuide.layoutFrame.width) - 20).isActive = true
        compView.heightAnchor.constraint(equalToConstant: (self.view.safeAreaLayoutGuide.layoutFrame.width) - 20).isActive = true
        compView.canSetupViews = true
        compView.size = self.size
        compView.alpha = 0
        UIView.animate(withDuration: 0.8, delay: 0, options: .transitionCrossDissolve, animations: {
            compView.alpha = 1.0
        }, completion: nil)
    }
    func setupFontSize(){
        self.size = DataService.instance.size
        if let s = DataService.instance.size, s == "ipad"{
            sendNewNotif.setAttributedTitle(NSAttributedString(string: "Send new notification", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 40)]), for: .normal)
        }else{
            sendNewNotif.setAttributedTitle(NSAttributedString(string: "Send new notification", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]), for: .normal)
        }
    }
    @objc func handleTeacherName(){
        if let email = currentEmailSignedIn{
            switch email {
            case "3@4.com":
                teacherName = "Mohamed English"
                break
            case "5@6.com":
                teacherName = "Mahmoud English"
                break
            default:
                teacherName = nil
            }
        }
    }
}

