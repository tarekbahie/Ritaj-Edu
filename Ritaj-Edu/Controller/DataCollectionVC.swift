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
        txt.backgroundColor = UIColor.systemTeal
        txt.attributedPlaceholder = NSAttributedString(string: "Full name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue])
        txt.tag = 100
        return txt
    }()
    let age : UITextField = {
        let txt = UITextField()
        txt.backgroundColor = UIColor.systemTeal
        txt.attributedPlaceholder = NSAttributedString(string: "Age", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue])
        txt.tag = 101
        return txt
    }()
    let schoolName : UITextField = {
        let txt = UITextField()
        txt.backgroundColor = UIColor.systemTeal
        txt.attributedPlaceholder = NSAttributedString(string: "School name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue])
        txt.tag = 102
        return txt
    }()
    let schoolGrade: UITextField = {
        let txt = UITextField()
        txt.backgroundColor = UIColor.systemTeal
        txt.attributedPlaceholder = NSAttributedString(string: "School grade", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue])
        txt.tag = 103
        return txt
    }()
    let sat1Subject1 : UITextField = {
        let txt = UITextField()
        txt.backgroundColor = UIColor.systemTeal
        txt.attributedPlaceholder = NSAttributedString(string: "First SAT subject", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue])
        txt.tag = 104
        return txt
    }()
    let sat1Subject2 : UITextField = {
        let txt = UITextField()
        txt.backgroundColor = UIColor.systemTeal
        txt.attributedPlaceholder = NSAttributedString(string: "Second SAT subject", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue])
        txt.tag = 105
        return txt
    }()
    let sat2Subject1 : UITextField = {
        let txt = UITextField()
        txt.backgroundColor = UIColor.systemTeal
        txt.attributedPlaceholder = NSAttributedString(string: "First SAT II subject", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue])
        txt.tag = 110
        return txt
    }()
    let sat2Subject2 : UITextField = {
        let txt = UITextField()
        txt.backgroundColor = UIColor.systemTeal
        txt.attributedPlaceholder = NSAttributedString(string: "Second SAT II subject", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue])
        txt.tag = 111
        return txt
    }()
    let updateData:UIButton={
        let btn = UIButton()
        btn.setTitle("Update Data", for: .normal)
        btn.backgroundColor = UIColor.systemBlue
        btn.tag = 106
        return btn
    }()
    let showNotifData:UIButton={
        let btn = UIButton()
        btn.setTitle("Show Notifications", for: .normal)
        btn.backgroundColor = UIColor.systemBlue
        btn.tag = 107
        return btn
    }()
    let showStudentData:UIButton={
        let btn = UIButton()
        btn.setTitle("Show Students data", for: .normal)
        btn.backgroundColor = UIColor.systemBlue
        btn.tag = 108
        return btn
    }()
    let txt : UITextView = {
        let txt = UITextView()
        txt.text = nil
        txt.font = UIFont.systemFont(ofSize: 20)
        txt.textAlignment = .center
        txt.isEditable = false
        txt.tag = 109
        return txt
    }()
    let txt2 : UITextView = {
        let txt = UITextView()
        txt.text = "Enter these subjects only if you are registering for SAT II"
        txt.font = UIFont.systemFont(ofSize: 12)
        txt.textAlignment = .center
        txt.isEditable = false
        txt.tag = 112
        return txt
    }()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        updateData.addTarget(self, action: #selector(handleData), for: .touchUpInside)
        showNotifData.addTarget(self, action: #selector(handleOldUser), for: .touchUpInside)
        showStudentData.addTarget(self, action: #selector(handleAdmin), for: .touchUpInside)
        if #available(iOS 13.0, *) {
            view.backgroundColor = UIColor.systemBackground
        } else {
            view.backgroundColor = .white
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.getRegisteredEmails { (names, emails) in
            self.n = names
            self.e = emails
            self.updateUIForCurrentUser()
        }
        
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
        let stack = UIStackView(arrangedSubviews: [image,stack1,stack2,stack3,txt2,stack4,updateData])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        newStackTop = stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 5)
        newStackTop?.isActive = true
        newStackLead = stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10)
        newStackLead?.isActive = true
        newStackTrail = stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10)
        newStackTrail?.isActive = true
        newStackHeight = stack.heightAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.height / 2)
        newStackHeight?.isActive = true
        txt2HeightConst = txt2.heightAnchor.constraint(equalToConstant: 20)
        txt2HeightConst?.isActive = true
        
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
        
    }
    func setupViewsForAdmin(){
        txt.text = "Welcome Mr.Hesham, You can press the button to view student data"
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
        for i in 110...112{
            view.viewWithTag(i)?.removeFromSuperview()
        }
        
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
        for i in 110...112{
            view.viewWithTag(i)?.removeFromSuperview()
        }
        
    }
    @objc func handleTap(){
        self.view.endEditing(true)
    }
    @objc func handleData(){
        if let email = Auth.auth().currentUser?.email{
            if let fN = fullName.text, fN != "", let a = age.text,a != "", let sN = schoolName.text, sN != "",let sG = schoolGrade.text, sG != "", let sat1 = sat1Subject1.text, sat1 != "" , let sat2 = sat1Subject2.text, sat2 != "",let sat21 = sat2Subject1.text,let s22 = sat2Subject2.text {
                DataService.instance.sendStudentUpdatedData(fN: fN, a: a, sN: sN, sG: sG, sat1: sat1, sat2: sat2, email: email, s21Sub: sat21, s22Sub: s22) { (succ,err) in
                    if let error = err{
                        self.showAlert(msg: error, title: "Error updating")
                    }else{
                        self.showAlert(msg: "Data updated", title: "Success")
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
        let adminVC = AdminVC()
        adminVC.modalPresentationStyle = .fullScreen
        self.present(adminVC, animated: true, completion: nil)
    }
    @objc func handleOldUser(){
        let centerAnnounceVC = CenterAnnouncementsVC()
        centerAnnounceVC.modalPresentationStyle = .fullScreen
        self.present(centerAnnounceVC, animated: true, completion: nil)
    }
    func showAlert(msg:String,title:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func updateUIForCurrentUser(){
        if let currentE = Auth.auth().currentUser?.email{
            if currentE == "1@2.om"{
                setupViewsForAdmin()
                return
            }else{
                if e.contains(currentE){
                   setupViewsForOldStudent()
                }else{
                    setupViewsForNewData()
                }
            }
        }else{
            showAlert(msg: "Please sign in first", title: "No user logged in")
        }
    }
    
}
