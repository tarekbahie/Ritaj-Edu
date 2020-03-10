//
//  AdminVC.swift
//  Ritaj-Edu
//
//  Created by tarek bahie on 3/3/20.
//  Copyright © 2020 tarek bahie. All rights reserved.
//

import UIKit
class AdminVC:UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,UICollectionViewDelegate{

    lazy var collectionView : UICollectionView = {
        let lay = UICollectionViewFlowLayout()
        let cView = UICollectionView(frame: .zero, collectionViewLayout: lay)
        cView.dataSource = self
        cView.delegate = self
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.backgroundColor = UIColor.systemTeal
        return cView
    }()
    let sendNewNotif:UIButton={
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Send New Notification", for: .normal)
        btn.backgroundColor = UIColor.systemBlue
        return btn
    }()
    let closeBtn:UIButton={
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            btn.setImage(UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate), for: .normal)
        } else {
            btn.setImage(UIImage(named: "close")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        btn.tintColor = .black
        btn.backgroundColor = UIColor.systemBlue
        btn.layer.cornerRadius = 25.0
        return btn
    }()
    var n = [String]()
    var a = [String]()
    var sN = [String]()
    var sG = [String]()
    var s1Subs = [String]()
    var s21Subjects:[String]?
    var s22Subjects:[String]?
    var s2Subs = [String](){
        didSet{
            collectionView.reloadData()
        }
    }
    var notifSubj : String?
    var notifMsg: String?{
        didSet{
            if notifMsg != "" {
                sendNewNotifToStudents()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(StudentCell.self, forCellWithReuseIdentifier: "studentCell")
        sendNewNotif.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        closeBtn.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        if #available(iOS 13.0, *) {
            view.backgroundColor = UIColor.systemBackground
        } else {
            view.backgroundColor = .white
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.getStudentsUpdatedData { (names, ages, sNames, sGrades, sat1, sat2,emai,s21Subs,s22Subs)   in
            self.n = names
            self.a = ages
            self.sN = sNames
            self.sG = sGrades
            self.s21Subjects = s21Subs
            self.s22Subjects = s22Subs
            self.s1Subs = sat1
            self.s2Subs = sat2
        }
        setupViews()
        setupCloseBtnView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        n.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "studentCell", for: indexPath) as! StudentCell
        if let s21 = s21Subjects,let s22 = s22Subjects{
            cell.configureCell(name: n[indexPath.item], age: a[indexPath.item], sName: sN[indexPath.item], sGrade: sG[indexPath.item], s1: s1Subs[indexPath.item], s2: s2Subs[indexPath.item], s21: s21[indexPath.item], s22: s22[indexPath.item])
        }else{
            cell.configureCell(name: n[indexPath.item], age: a[indexPath.item], sName: sN[indexPath.item], sGrade: sG[indexPath.item], s1: s1Subs[indexPath.item], s2: s2Subs[indexPath.item], s21: "", s22: "")
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: view.safeAreaLayoutGuide.layoutFrame.height / 2)
    }
    func setupViews(){
        view.addSubview(collectionView)
        view.addSubview(sendNewNotif)
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: sendNewNotif.topAnchor,constant: -10).isActive = true
        
        sendNewNotif.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        sendNewNotif.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        sendNewNotif.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        sendNewNotif.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    @objc func handleSend(){
        var subjField: UITextField?
        var msgField : UITextField?
        let searchAlert = UIAlertController(title: "New Notification", message: "Type subject of notification and notification ", preferredStyle: .alert)
        searchAlert.addTextField { (textField) in
            textField.placeholder = "Subject of notification'"
            subjField = textField
        }
        searchAlert.addTextField { (tField) in
            tField.placeholder = "Notification message"
            msgField = tField
        }
        let search = UIAlertAction(title: "Send", style: .default) { (UIAlertAction) in
            if let sub = subjField?.text,subjField?.text != ""{
                self.notifSubj = sub
            }
            if let msg = msgField?.text, msgField?.text != ""{
                self.notifMsg = msg
            }
        }
        let cancel = UIAlertAction(title: "cancel", style: .destructive) { (UIAlertAction) in
            searchAlert.dismiss(animated: true, completion: nil)
        }
        searchAlert.addAction(search)
        searchAlert.addAction(cancel)
        self.present(searchAlert, animated: true, completion: nil)
    }
    func sendNewNotifToStudents(){
        guard let subj = notifSubj, let msg = notifMsg else{return}
        DataService.instance.sendNotificationsToStudents(subject: subj, notif: msg) { (success, err) in
            if let error = err{
                self.showAlert(msg: error, title: "Error sending message")
            }else{
                self.showAlert(msg: "Message Sent", title: "Success")
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
    func setupCloseBtnView(){
        view.addSubview(closeBtn)
        closeBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 5).isActive = true
        closeBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -5).isActive = true
        closeBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        closeBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    @objc func handleClose(){
        self.dismiss(animated: true, completion: nil)
    }
}
