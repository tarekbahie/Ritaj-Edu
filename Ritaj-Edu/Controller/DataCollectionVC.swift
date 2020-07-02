//
//  DataCollectionVC.swift
//  Ritaj-Edu
//
//  Created by tarek bahie on 3/3/20.
//  Copyright © 2020 tarek bahie. All rights reserved.
//

import UIKit
import Firebase
class DataCollectionVC:UIViewController{
    let image : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "retaj")
        img.contentMode = .scaleAspectFit
        return img
    }()
    let fullName : UITextField = {
        let txt = UITextField()
        txt.backgroundColor = UIColor(named: "retajBlue")
        txt.placeholder = "Full name"
        txt.tag = 100
        return txt
    }()
    let age : UITextField = {
        let txt = UITextField()
        txt.backgroundColor = UIColor(named: "retajBlue")
        txt.placeholder = "Age"
        txt.tag = 101
        return txt
    }()
    let schoolName : UITextField = {
        let txt = UITextField()
        txt.backgroundColor = UIColor.systemTeal
        txt.backgroundColor = UIColor(named: "retajBlue")
        txt.placeholder = "School name"
        txt.tag = 102
        return txt
    }()
    let schoolGrade: UITextField = {
        let txt = UITextField()
        txt.backgroundColor = UIColor(named: "retajBlue")
        txt.placeholder = "School grade"
        txt.tag = 103
        return txt
    }()
    let sat1Subject1 : UITextField = {
        let txt = UITextField()
        txt.backgroundColor = UIColor(named: "retajBlue")
        txt.placeholder = "Father's Name"
        txt.tag = 104
        return txt
    }()
    let sat1Subject2 : UITextField = {
        let txt = UITextField()
        txt.backgroundColor = UIColor(named: "retajBlue")
        txt.placeholder = "Mother's Name"
        txt.tag = 105
        return txt
    }()
    let sat2Subject1 : UITextField = {
        let txt = UITextField()
        txt.backgroundColor = UIColor(named: "retajBlue")
        txt.placeholder = "Father's Mobile Number"
        txt.tag = 110
        return txt
    }()
    let sat2Subject2 : UITextField = {
        let txt = UITextField()
        txt.backgroundColor = UIColor(named: "retajBlue")
        txt.placeholder = "Mother's Mobile Number"
        txt.tag = 111
        return txt
    }()
    let referal : UITextField = {
        let txt = UITextField()
        txt.backgroundColor = UIColor(named: "retajBlue")
        txt.placeholder = "Mobile Number"
        txt.tag = 113
        return txt
    }()
    let updateData:UIButton={
        let btn = UIButton()
        btn.backgroundColor = UIColor(named: "retajBlue")
        btn.setTitleColor(UIColor(named: "retajGreen"), for: .normal)
        btn.tag = 106
        return btn
    }()
    let updateSATData:UIButton={
        let btn = UIButton()
        btn.backgroundColor = UIColor(named: "retajBlue")
        btn.setTitleColor(UIColor(named: "retajGreen"), for: .normal)
        btn.tag = 166
        return btn
    }()
    let showNotifData:UIButton={
        let btn = UIButton()
        btn.backgroundColor = UIColor(named: "retajBlue")
        btn.setTitleColor(UIColor(named: "retajGreen"), for: .normal)
        btn.tag = 107
        return btn
    }()
    let showStudentData:UIButton={
        let btn = UIButton()
        btn.backgroundColor = UIColor(named: "retajBlue")
        btn.setTitleColor(UIColor(named: "retajGreen"), for: .normal)
        btn.tag = 108
        return btn
    }()
    let txt : UITextView = {
        let txt = UITextView()
        txt.text = nil
        txt.textAlignment = .center
        txt.isEditable = false
        txt.tag = 109
        txt.backgroundColor = UIColor(named: "retajGreen")
        txt.textColor = UIColor(named: "retajBlue")
        return txt
    }()
//    let txt2 : UILabel = {
//        let txt = UILabel()
//        txt.text = "Enter these subjects only if you are registering for SAT II"
//        txt.textAlignment = .center
//        txt.adjustsFontSizeToFitWidth = true
//        txt.minimumScaleFactor = 0.5
//        txt.tag = 112
//        txt.backgroundColor = UIColor(named: "retajGreen")
//        txt.textColor = UIColor(named: "retajBlue")
//        return txt
//    }()
    var n = [String]()
    var e = [String]()
    var newStackTop:NSLayoutConstraint?
    var newStackHeight:NSLayoutConstraint?
    var newStackTrail:NSLayoutConstraint?
    var newStackLead:NSLayoutConstraint?
    var oldStackTop:NSLayoutConstraint?
    var oldStackBottom:NSLayoutConstraint?
    var oldStackTrail:NSLayoutConstraint?
    var oldStackLead:NSLayoutConstraint?
    var admStackTop:NSLayoutConstraint?
    var admStackBottom:NSLayoutConstraint?
    var admStackTrail:NSLayoutConstraint?
    var admStackLead:NSLayoutConstraint?
    
    var txtHeightConst:NSLayoutConstraint?
    var txt2HeightConst:NSLayoutConstraint?
    var size:String?
    var referredBy = ""{
        didSet{
            if referredBy != ""{
                setupViewsForNewData()
            }
        }
    }
    var currentEmailSignedIn:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        updateData.addTarget(self, action: #selector(handleData), for: .touchUpInside)
        updateSATData.addTarget(self, action: #selector(handleSat), for: .touchUpInside)
        showNotifData.addTarget(self, action: #selector(handleOldUser), for: .touchUpInside)
        showStudentData.addTarget(self, action: #selector(handleAdmin), for: .touchUpInside)
        self.navigationItem.title = "Student"
        view.backgroundColor = UIColor(named: "retajGreen")
        updateSATData.isHidden = true
    }
    fileprivate func getEmailsToSetupViews() {
        DataService.instance.getRegisteredEmails { (names, emails,err) in
            self.size = DataService.instance.size
            if let error = err, error == true{
                self.updateUIForCurrentUser()
            }else{
                self.n = names!
                self.e = emails!
                DispatchQueue.main.async {
                    self.updateUIForCurrentUser()
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getEmailsToSetupViews()
        
    }
    func setupViewsForNewData(){
        let stack1 = UIStackView(arrangedSubviews: [fullName,age])
        stack1.axis = .horizontal
        stack1.distribution = .fillEqually
        stack1.spacing = 10
        let stack2 = UIStackView(arrangedSubviews: [schoolGrade,schoolName])
        stack2.axis = .horizontal
        stack2.distribution = .fillEqually
        stack2.spacing = 10
        let stack3 = UIStackView(arrangedSubviews: [sat1Subject1,sat1Subject2])
        stack3.axis = .horizontal
        stack3.distribution = .fillEqually
        stack3.spacing = 10
        let stack4 = UIStackView(arrangedSubviews: [sat2Subject1,sat2Subject2])
        stack4.axis = .horizontal
        stack4.distribution = .fillEqually
        stack4.spacing = 10
        let stack = UIStackView(arrangedSubviews: [stack1,stack2,referal,stack3,stack4,updateData,updateSATData])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        newStackTop = stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 5)
        newStackTop?.isActive = true
        newStackLead = stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10)
        newStackLead?.isActive = true
        newStackTrail = stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10)
        newStackTrail?.isActive = true
        newStackHeight = stack.heightAnchor.constraint(equalToConstant: (view.safeAreaLayoutGuide.layoutFrame.height / 2) + 50)
        newStackHeight?.isActive = true
        
        oldStackTop?.isActive = false
        oldStackTrail?.isActive = false
        oldStackLead?.isActive = false
        oldStackBottom?.isActive = false
        admStackTop?.isActive = false
        admStackLead?.isActive = false
        admStackTrail?.isActive = false
        admStackBottom?.isActive = false
        txtHeightConst?.isActive = false
        for i in 107...109{
            view.viewWithTag(i)?.removeFromSuperview()
        }
        setupFontSize(newS: true)
        
    }
    func setupViewsForAdmin(name:String){
        txt.text = "Welcome \(name), You can press the button to view student data"
        let stack = UIStackView(arrangedSubviews: [image,txt,showStudentData])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        admStackTop = stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 5)
        admStackTop?.isActive = true
        admStackLead = stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10)
        admStackLead?.isActive = true
        admStackTrail = stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10)
        admStackTrail?.isActive = true
        admStackBottom = stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -5)
        admStackBottom?.isActive = true
        
        txtHeightConst = txt.heightAnchor.constraint(equalToConstant: 80)
        txtHeightConst?.isActive = true
        
        oldStackTop?.isActive = false
        oldStackTrail?.isActive = false
        oldStackLead?.isActive = false
        oldStackBottom?.isActive = false
        newStackTop?.isActive = false
        newStackTrail?.isActive = false
        newStackLead?.isActive = false
        newStackHeight?.isActive = false
        txt2HeightConst?.isActive = false
        
        for i in 100...107{
            view.viewWithTag(i)?.removeFromSuperview()
        }
        for i in 110...113{
            view.viewWithTag(i)?.removeFromSuperview()
        }
        setupFontSize(newS: nil)
    }
    func setupViewsForOldStudent(){
        txt.text = "Welcome \(Auth.auth().currentUser?.email ?? ""), You can press the button to view all notifications"
        let stack = UIStackView(arrangedSubviews: [image,txt,showNotifData])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        oldStackTop = stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 5)
        oldStackTop?.isActive = true
        oldStackLead = stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10)
        oldStackLead?.isActive = true
        oldStackTrail = stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10)
        oldStackTrail?.isActive = true
        oldStackBottom = stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -5)
        oldStackBottom?.isActive = true
        txtHeightConst = txt.heightAnchor.constraint(equalToConstant: 80)
        txtHeightConst?.isActive = true
        
        newStackTop?.isActive = false
        newStackTrail?.isActive = false
        newStackLead?.isActive = false
        newStackHeight?.isActive = false
        admStackTop?.isActive = false
        admStackLead?.isActive = false
        admStackTrail?.isActive = false
        admStackBottom?.isActive = false
        txt2HeightConst?.isActive = false
        
        for i in 100...106{
            view.viewWithTag(i)?.removeFromSuperview()
        }
        view.viewWithTag(108)?.removeFromSuperview()
        view.viewWithTag(166)?.removeFromSuperview()
        for i in 110...113{
            view.viewWithTag(i)?.removeFromSuperview()
        }
        setupFontSize(newS: nil)
    }
    func setupViewsForOldStudentSatData(){
        updateSATData.isHidden = false
        txt.text = "Welcome \(Auth.auth().currentUser?.email ?? ""), Please update your sat data"
        let stack = UIStackView(arrangedSubviews: [image,txt,updateSATData])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        oldStackTop = stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 5)
        oldStackTop?.isActive = true
        oldStackLead = stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10)
        oldStackLead?.isActive = true
        oldStackTrail = stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10)
        oldStackTrail?.isActive = true
        oldStackBottom = stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -5)
        oldStackBottom?.isActive = true
        txtHeightConst = txt.heightAnchor.constraint(equalToConstant: 80)
        txtHeightConst?.isActive = true
        
        newStackTop?.isActive = false
        newStackTrail?.isActive = false
        newStackLead?.isActive = false
        newStackHeight?.isActive = false
        admStackTop?.isActive = false
        admStackLead?.isActive = false
        admStackTrail?.isActive = false
        admStackBottom?.isActive = false
        txt2HeightConst?.isActive = false
        
        for i in 100...106{
            view.viewWithTag(i)?.removeFromSuperview()
        }
        view.viewWithTag(108)?.removeFromSuperview()
        for i in 110...113{
            view.viewWithTag(i)?.removeFromSuperview()
        }
        setupFontSize(newS: nil)
    }
    @objc func handleTap(){
        self.view.endEditing(true)
    }
    @objc func handleData(){
        if let email = Auth.auth().currentUser?.email{
            if let fN = fullName.text, fN != "", let a = age.text,a != "", let sN = schoolName.text, sN != "",let sG = schoolGrade.text, sG != "", let fatherN = sat1Subject1.text, fatherN != "" , let motherN = sat1Subject2.text, motherN != "",let fatherNumb = sat2Subject1.text,let motherNumb = sat2Subject2.text,let mobile = referal.text {
                DataService.instance.sendStudentUpdatedData(fN: fN, a: a, sN: sN, sG: sG, sat1: fatherN, sat2: motherN, email: email, s21Sub: fatherNumb, s22Sub: motherNumb, refer: mobile, referal: self.referredBy) { (succ,err) in
                    if let error = err{
                        self.showAlert(msg: error, title: "Error updating")
                    }else{
                        DataService.instance.getStudentsNotificationsFromAdmin { (subjs, bodies) in
                            if subjs.count > 0 {
                                for i in 0...subjs.count - 1{
                                    if subjs[i] == "Password"{
                                        self.getEmailsToSetupViews()
                                        self.showAlert(msg: "Data updated and the wifi password is \(bodies[i])", title: "Success")
                                        return
                                    }else if i == subjs.count - 1{
                                        self.getEmailsToSetupViews()
                                        self.showAlert(msg: "Data updated", title: "Success")
                                        
                                    }
                                }
                            }else{
                                self.getEmailsToSetupViews()
                                self.showAlert(msg: "Data updated", title: "Success")
                            }
                        }
                    }
                }
            }else{
                showAlert(msg: "Please check for missing data", title: "Incomplete Data")
            }
        }else{
            showAlert(msg: "Please Sign in first", title: "Not signed in")
        }
    }
    @objc func handleAdmin(){
        guard let currentE = currentEmailSignedIn else{return}
        switch currentE {
        case "1@2.om":
            let adminVC = AdminVC()
            adminVC.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(adminVC, animated: true)
        default:
            let teachVC = TeacherVC()
            teachVC.currentEmailSignedIn = currentE
            teachVC.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(teachVC, animated: true)
        }
    }
    @objc func handleOldUser(){
        let centerAnnounceVC = CenterAnnouncementsVC()
        centerAnnounceVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(centerAnnounceVC, animated: true)
    }
    func showAlert(msg:String,title:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func updateUIForCurrentUser(){
        // need to change admin email and then upload to appstore
        if let currentE = Auth.auth().currentUser?.email{
            switch currentE {
            case "1@2.om":
                currentEmailSignedIn = "1@2.om"
                setupViewsForAdmin(name: "Mr.Hesham")
                break
            case "3@4.com":
                currentEmailSignedIn = "3@4.com"
                setupViewsForAdmin(name: "Mr.Mohamed")
                break
            case "5@6.com":
                currentEmailSignedIn = "5@6.com"
                setupViewsForAdmin(name: "Mr.Mahmoud")
                break
            default:
                if e.contains(currentE){
                    if let savedE = savedSatData.object(forKey: "Saved") as? String,savedE == currentE{
                        print(savedE,currentE)
                        setupViewsForOldStudent()
                    }else{
                       setupViewsForOldStudentSatData()
                    }
                }else{
                    setupStudentreferal()
                    
                }
            }
        }else{
            showAlert(msg: "Please sign in first", title: "No user logged in")
        }
    }
    func setupFontSize(newS:Bool?){
        guard let _ = size else{
            fullName.font = UIFont.systemFont(ofSize: 18)
            age.font = UIFont.systemFont(ofSize: 18)
            schoolGrade.font = UIFont.systemFont(ofSize: 18)
            schoolName.font = UIFont.systemFont(ofSize: 18)
            referal.font = UIFont.systemFont(ofSize: 18)
            sat1Subject1.font = UIFont.systemFont(ofSize: 18)
            sat1Subject2.font = UIFont.systemFont(ofSize: 18)
            sat2Subject1.font = UIFont.systemFont(ofSize: 14)
            sat2Subject2.font = UIFont.systemFont(ofSize: 14)
            
            updateData.setAttributedTitle(NSAttributedString(string: "Update Data", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20),NSAttributedString.Key.foregroundColor:UIColor(named: "retajGreen")!]), for: .normal)
            updateSATData.setAttributedTitle(NSAttributedString(string: "Update SAT Data", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20),NSAttributedString.Key.foregroundColor:UIColor(named: "retajGreen")!]), for: .normal)
            showNotifData.setAttributedTitle(NSAttributedString(string: "Show notifications", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20),NSAttributedString.Key.foregroundColor:UIColor(named: "retajGreen")!]), for: .normal)
            showStudentData.setAttributedTitle(NSAttributedString(string: "Show students data", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20),NSAttributedString.Key.foregroundColor:UIColor(named: "retajGreen")!]), for: .normal)
//            txt2.font = UIFont.systemFont(ofSize: 18)
            txt.font = UIFont.systemFont(ofSize: 18)
            return
        }
        fullName.font = UIFont.systemFont(ofSize: 40)
        age.font = UIFont.systemFont(ofSize: 40)
        schoolGrade.font = UIFont.systemFont(ofSize: 40)
        schoolName.font = UIFont.systemFont(ofSize: 40)
        referal.font = UIFont.systemFont(ofSize: 40)
        sat1Subject1.font = UIFont.systemFont(ofSize: 40)
        sat1Subject2.font = UIFont.systemFont(ofSize: 40)
        sat2Subject1.font = UIFont.systemFont(ofSize: 40)
        sat2Subject2.font = UIFont.systemFont(ofSize: 40)
        updateData.setAttributedTitle(NSAttributedString(string: "Update data", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 40),NSAttributedString.Key.foregroundColor:UIColor(named: "retajGreen")!]), for: .normal)
        updateSATData.setAttributedTitle(NSAttributedString(string: "Update SAT data", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 40),NSAttributedString.Key.foregroundColor:UIColor(named: "retajGreen")!]), for: .normal)
        showNotifData.setAttributedTitle(NSAttributedString(string: "Show notifications", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 40),NSAttributedString.Key.foregroundColor:UIColor(named: "retajGreen")!]), for: .normal)
        showStudentData.setAttributedTitle(NSAttributedString(string: "Show students data", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 40),NSAttributedString.Key.foregroundColor:UIColor(named: "retajGreen")!]), for: .normal)
//        txt2.font = UIFont.systemFont(ofSize: 40)
        txt.font = UIFont.systemFont(ofSize: 34)
    }
    @objc func handleSat(){
        let studentSat = StudentSatDataVC()
        studentSat.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(studentSat, animated: true)
    }
    func setupStudentreferal(){
        let alert = UIAlertController(title: "How did you know about us", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ads", style: .default, handler: { (UIAlertAction) in
            self.referredBy = "Ads"
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Colleague", style: .default, handler: { (UIAlertAction) in
            self.referredBy = "Colleague"
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Teacher", style: .default, handler: { (UIAlertAction) in
            self.referredBy = "Teacher"
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
