//
//  LoginOrRegisterVC.swift
//  Ritaj-Edu
//
//  Created by tarek bahie on 3/2/20.
//  Copyright © 2020 tarek bahie. All rights reserved.
//

import UIKit
import Firebase
class LoginOrRegisterVC:UIViewController{
    let image : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "retaj")
        img.contentMode = .scaleAspectFit
        return img
    }()
    let loginBtn:UIButton={
        let btn = UIButton()
        btn.backgroundColor = UIColor(named: "retajBlue")
        btn.tag = 100
        return btn
    }()
    let registerBtn:UIButton={
        let btn = UIButton()
        btn.backgroundColor = UIColor(named: "retajBlue")
        btn.tag = 101
        return btn
    }()
    let txt : UITextView = {
        let txt = UITextView()
        txt.textAlignment = .center
        txt.isEditable = false
        txt.tag = 102
        return txt
    }()
    let logOutBtn:UIButton={
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Logout", for: .normal)
        btn.backgroundColor = UIColor(named: "retajGreen")
        btn.tag = 103
        return btn
    }()
    
    var stackNoUserTopConstraint : NSLayoutConstraint?
    var stackNoUserbottomConstraint : NSLayoutConstraint?
    var stackNoUserleadingConstraint : NSLayoutConstraint?
    var stackNoUserTrailingConstraint : NSLayoutConstraint?
    var txtNoUserHeightConstraint : NSLayoutConstraint?
    var stackUserTopConstraint : NSLayoutConstraint?
    var stackUserbottomConstraint : NSLayoutConstraint?
    var stackUserleadingConstraint : NSLayoutConstraint?
    var stackUserTrailingConstraint : NSLayoutConstraint?
    var logOutBtnTopConstraint : NSLayoutConstraint?
    var logOutBtnWidthConstraint : NSLayoutConstraint?
    var logOutBtnHeightConstraint : NSLayoutConstraint?
    var logOutBtnTrailingConstraint : NSLayoutConstraint?
    var logInBtnHeightConstraint : NSLayoutConstraint?
    var registerBtnHeightConstraint : NSLayoutConstraint?
    var size:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "retajGreen")
    }
    func setupViewsForNoUserSignedIn(){
        let stack = UIStackView(arrangedSubviews: [image,loginBtn,registerBtn,txt])
//        txt.text = nil
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        stackUserTopConstraint?.isActive = false
        stackUserbottomConstraint?.isActive = false
        stackUserleadingConstraint?.isActive = false
        stackUserTrailingConstraint?.isActive = false
        logOutBtnTopConstraint?.isActive = false
        logOutBtnWidthConstraint?.isActive = false
        logOutBtnHeightConstraint?.isActive = false
        logOutBtnTrailingConstraint?.isActive = false
        registerBtnHeightConstraint?.isActive = false
        logInBtnHeightConstraint?.isActive = false
        
        stackNoUserTopConstraint = stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10)
        stackNoUserTopConstraint?.isActive = true
        stackNoUserleadingConstraint = stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10)
        stackNoUserleadingConstraint?.isActive = true
        stackNoUserTrailingConstraint = stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10)
        stackNoUserTrailingConstraint?.isActive = true
        stackNoUserbottomConstraint = stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10)
        stackNoUserbottomConstraint?.isActive = true
        
        txtNoUserHeightConstraint = txt.heightAnchor.constraint(equalToConstant: 80)
        txtNoUserHeightConstraint?.isActive = true
        image.heightAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.height / 3).isActive = true
        view.viewWithTag(103)?.removeFromSuperview()
        
    }
    func setupViewsForSignedInUser(email:String){
        txt.text = email
        let stack = UIStackView(arrangedSubviews: [image,txt])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        view.addSubview(logOutBtn)
        
        logOutBtnTopConstraint =  logOutBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10)
        logOutBtnTopConstraint?.isActive = true
        logOutBtnTrailingConstraint = logOutBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        logOutBtnTrailingConstraint?.isActive = true
        logOutBtnWidthConstraint = logOutBtn.widthAnchor.constraint(equalToConstant: 100)
        logOutBtnWidthConstraint?.isActive = true
        logOutBtnHeightConstraint = logOutBtn.heightAnchor.constraint(equalToConstant: 30)
        logOutBtnHeightConstraint?.isActive = true
        
        stackUserTopConstraint = stack.topAnchor.constraint(equalTo: logOutBtn.bottomAnchor,constant: 10)
        stackUserTopConstraint?.isActive = true
        stackUserleadingConstraint = stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10)
        stackUserleadingConstraint?.isActive = true
        stackUserTrailingConstraint = stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10)
        stackUserTrailingConstraint?.isActive = true
        stackUserbottomConstraint = stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        stackUserbottomConstraint?.isActive = true
        
        txtNoUserHeightConstraint = txt.heightAnchor.constraint(equalToConstant: 80)
        txtNoUserHeightConstraint?.isActive = true
        
        stackNoUserTopConstraint?.isActive = false
        stackNoUserleadingConstraint?.isActive = false
        stackNoUserTrailingConstraint?.isActive = false
        stackNoUserbottomConstraint?.isActive = false
        registerBtnHeightConstraint?.isActive = false
        logInBtnHeightConstraint?.isActive = false
        image.heightAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.height / 3).isActive = true
        for i in 100...101{
            view.viewWithTag(i)?.removeFromSuperview()
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupFontSize()
        self.navigationItem.title = "Account"
        registerBtn.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        loginBtn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        guard let email = Auth.auth().currentUser?.email else{
         setupViewsForNoUserSignedIn()
            return
        }
        setupViewsForSignedInUser(email: email)
        logOutBtn.addTarget(self, action: #selector(handleSignOut), for: .touchUpInside)
    }
    
    @objc func handleLogin(){
        let loginVC = LoginVC()
        loginVC.modalPresentationStyle = .fullScreen
        navigationController?.present(loginVC, animated: true, completion: nil)
    }
    @objc func handleRegister(){
        let regVC = RegisterVC()
        regVC.modalPresentationStyle = .fullScreen
        navigationController?.present(regVC, animated: true, completion: nil)
    }
    @objc func handleSignOut(){
            do {
                try Auth.auth().signOut()
                setupViewsForNoUserSignedIn()
                showAlert(msg: "Signed Out", title: "Success")
            }catch let err{
                showAlert(msg: err.localizedDescription, title: "Error signing out")
            }
    }
    func showAlert(msg:String,title:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func setupFontSize(){
        guard let _ = DataService.instance.size else{
            loginBtn.setAttributedTitle(NSAttributedString(string: "Sign in", attributes: [NSAttributedString.Key.foregroundColor:UIColor(named: "retajGreen")!,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]), for: .normal)
            registerBtn.setAttributedTitle(NSAttributedString(string: "Register a new user", attributes: [NSAttributedString.Key.foregroundColor:UIColor(named: "retajGreen")!,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]), for: .normal)
            logOutBtn.setAttributedTitle(NSAttributedString(string: "Logout", attributes: [NSAttributedString.Key.foregroundColor:UIColor(named: "retajBlue")!,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]), for: .normal)
            txt.font = UIFont.systemFont(ofSize: 15)
            txt.text = "Register or sign in to receive updates and notifications regarding your subjects"
            txt.backgroundColor = UIColor(named: "retajGreen")
            txt.textColor = UIColor(named: "retajBlue")
            return
        }
        loginBtn.setAttributedTitle(NSAttributedString(string: "Sign in", attributes: [NSAttributedString.Key.foregroundColor:UIColor(named: "retajBlue")!,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 40),NSAttributedString.Key.foregroundColor: UIColor(named: "retajGreen")!]), for: .normal)
        registerBtn.setAttributedTitle(NSAttributedString(string: "Register a new user", attributes: [NSAttributedString.Key.foregroundColor:UIColor(named: "retajBlue")!,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 40),NSAttributedString.Key.foregroundColor: UIColor(named: "retajGreen")!]), for: .normal)
        logOutBtn.setAttributedTitle(NSAttributedString(string: "Logout", attributes: [NSAttributedString.Key.foregroundColor:UIColor(named: "retajBlue")!,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20),NSAttributedString.Key.foregroundColor: UIColor(named: "retajGreen")!]), for: .normal)
        txt.font = UIFont.systemFont(ofSize: 30)
        txt.text = "Register or sign in to receive updates and notifications regarding your subjects"
        txt.backgroundColor = UIColor(named: "retajGreen")
        txt.textColor = UIColor(named: "retajBlue")
        
    }
}
