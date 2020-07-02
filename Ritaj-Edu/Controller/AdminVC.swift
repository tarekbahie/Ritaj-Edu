//
//  AdminVC.swift
//  Ritaj-Edu
//
//  Created by tarek bahie on 3/3/20.
//  Copyright © 2020 tarek bahie. All rights reserved.
//

import UIKit
import Firebase
import SwiftCSVExport
class AdminVC:UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,UICollectionViewDelegate{
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
    var paidEmail:String?
    var paymentStatus:Bool?=false{
        didSet{
            if paymentStatus == true{
                DataService.instance.updatePayment(status: "paid", email: paidEmail!) { (success, errorDesc) in
                    if let err = errorDesc{
                        print(err)
                    }else{
                        self.getStudentData()
                    }
                }
            }
        }
    }
    var fathersNa = [String]()
    var mothersNa = [String]()
    var fathersNum = [String]()
    var mothersNum = [String]()
    var emails = [String]()
    var s11Subs = [String]()
    var s21Subjects:[String]?
    var s22Subjects:[String]?
    var s23Subjects:[String]?
    var payments:[String]?
    var referals=[String]()
    var tokensForNotifs=[String]()
    var s2Subs = [String](){
        didSet{
            print("count",n.count)
            collectionView.reloadData()
            self.navigationItem.title = "\(n.count) student/s"
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Export excel", style: .plain, target: self, action: #selector(self.handleExport))
        }
    }
    var notifSubj : String?
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(StudentCell.self, forCellWithReuseIdentifier: "studentCell")
        sendNewNotif.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        view.backgroundColor = UIColor(named: "retajGreen")
    }
    fileprivate func getStudentData() {
        DataService.instance.getStudentsUpdatedData { (names,ages,sNames,sGrades,mobiles,fathers,mothers,emails,fathersNum,mothersNum,s11Subs,s12Subs,s21Subs,s22Subs,s23Subs,payments,reference,tokens)     in
            self.n = names
            self.a = ages
            self.sN = sNames
            self.sG = sGrades
            self.mob = mobiles
            self.fathersNa = fathers
            self.mothersNa = mothers
            self.fathersNum = fathersNum
            self.mothersNum = mothersNum
            self.s11Subs = s11Subs
            self.emails = emails
            self.s21Subjects = s21Subs
            self.s22Subjects = s22Subs
            self.s23Subjects = s23Subs
            self.payments = payments
            self.referals = reference
            self.tokensForNotifs = tokens
            self.s2Subs = s12Subs
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getStudentData()
        setupViews()
        setupFontSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        n.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "studentCell", for: indexPath) as! StudentCell
        var s21sub:String?
        var s22sub:String?
        var s23sub:String?
        if let s21s = s21Subjects,s21s.count > 0{
            s21sub = s21s[indexPath.item]
        }
        if let s22s = s22Subjects,s22s.count > 0{
            s22sub = s22s[indexPath.item]
        }
        if let s23s = s23Subjects,s23s.count > 0{
            s23sub = s23s[indexPath.item]
        }
        
        cell.configureCell(name: n[indexPath.item], age: a[indexPath.item], sName: sN[indexPath.item], sGrade: sG[indexPath.item], mob: mob[indexPath.item],mail: emails[indexPath.item], fathName: fathersNa[indexPath.item], fathNum: fathersNum[indexPath.item], mothName: mothersNa[indexPath.item], mothNum: mothersNum[indexPath.item], s11: s11Subs[indexPath.item], s12: s2Subs[indexPath.item], s21: s21sub, s22: s22sub, s23: s23sub, payments: self.payments?[indexPath.item] ?? "Not paid", ref: referals[indexPath.item], size: size)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: view.safeAreaLayoutGuide.layoutFrame.height)
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
        let composeView = ComposeMsgView()
        composeView.home = self
        composeView.tag = 1000
        self.addView(compView: composeView)
    }
    func sendNewNotifToStudents(){
        guard let subj = notifSubj, let msg = notifMsg else{return}
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy HH:mm:ss"
        let date = Date()
        let res = formatter.string(from: date)
        let time = formatter.date(from: res)
        let stamp = Timestamp(date: time!)
        DataService.instance.sendNotificationsToStudents(senderName: "Admin", subject: subj, notif: msg, time: stamp) { (success, err) in
            if let error = err{
                self.showAlert(msg: error, title: "Error sending message")
            }else{
                self.showAlert(msg: "Message Sent", title: "Success")
                self.sendPushNotifToStudents(title: subj, body: msg)
            }
        }
    }
    func sendPushNotifToStudents(title:String,body:String){
        if !tokensForNotifs.isEmpty{
            for t in tokensForNotifs{
                let sender = PushNotificationSender()
                sender.sendPushNotification(to: t, title: title, body: body)
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
    func addView(compView:ComposeMsgView){
        compView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(compView)
        compView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        compView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        compView.widthAnchor.constraint(equalToConstant: self.view.safeAreaLayoutGuide.layoutFrame.width).isActive = true
        compView.heightAnchor.constraint(equalToConstant: self.view.safeAreaLayoutGuide.layoutFrame.height).isActive = true
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let name = self.n[indexPath.item]
        let mail = self.emails[indexPath.item]
        setupStudentPaymentData(name: name, email: mail)
    }
    func setupStudentPaymentData(name:String,email:String){
        let alert = UIAlertController(title: "Update payment status", message: "did \(name) pay his due fees ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (UIAlertAction) in
            self.paidEmail = email
            self.paymentStatus = true
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (UIAlertAction) in
            self.paymentStatus = false
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @objc func handleExport(){
        let data:NSMutableArray  = NSMutableArray()
        let header = ["Name", "Age", "School Name", "School Grade", "Mobile","Email","Father's Name","Father's Mob","Mother's Name","Mother's Mob","Sat1 Sub1","Sat1 Sub2","Sat2 Sub1","Sat2 Sub2","Sat2 Sub3","Refered By","Payment Status"]
        for ind in 0..<n.count{
            let user:NSMutableDictionary = NSMutableDictionary()
            user.setObject(n[ind], forKey: "Name" as NSCopying)
            user.setObject(a[ind], forKey: "Age" as NSCopying)
            user.setObject(sN[ind], forKey: "School Name" as NSCopying)
            user.setObject(sG[ind], forKey: "School Grade" as NSCopying)
            user.setObject(mob[ind], forKey: "Mobile" as NSCopying)
            user.setObject(fathersNa[ind], forKey: "Father's Name" as NSCopying)
            user.setObject(mothersNa[ind], forKey: "Mother's Name" as NSCopying)
            user.setObject(fathersNum[ind], forKey: "Father's Mob" as NSCopying)
            user.setObject(mothersNum[ind], forKey: "Mother's Mob" as NSCopying)
            user.setObject(s11Subs[ind], forKey: "Sat1 Sub1" as NSCopying)
            user.setObject(emails[ind], forKey: "Email" as NSCopying)
            user.setObject(s21Subjects![ind], forKey: "Sat2 Sub1" as NSCopying)
            user.setObject(s22Subjects![ind], forKey: "Sat2 Sub2" as NSCopying)
            user.setObject(s23Subjects![ind], forKey: "Sat2 Sub3" as NSCopying)
            user.setObject(payments![ind], forKey: "Payment Status" as NSCopying)
            user.setObject(s2Subs[ind], forKey: "Sat1 Sub2" as NSCopying)
            user.setObject(referals[ind], forKey: "Refered By" as NSCopying)
            data.add(user)
        }
        let writeCSVObj = CSV()
        writeCSVObj.rows = data
        writeCSVObj.delimiter = DividerType.comma.rawValue
        writeCSVObj.fields = header as NSArray
        writeCSVObj.name = "userlist"
        let result = CSVExport.export(writeCSVObj)
        if result.result.isSuccess {
            guard let filePath =  result.filePath else {
                print("Export Error: \(String(describing: result.message))")
                return
            }
            print("File Path: \(filePath)")
            self.readCSVPath(filePath)
    }
}
    func readCSVPath(_ filePath: String) {

            let request = NSURLRequest(url:  URL(fileURLWithPath: filePath) )
//            let readCSVObj = CSVExport.readCSVObject(filePath)
        let ex = ExcelVC()
        ex.modalPresentationStyle = .fullScreen
        ex.request = request
        ex.fileP = filePath
        navigationController?.pushViewController(ex, animated: true)
        }
}
