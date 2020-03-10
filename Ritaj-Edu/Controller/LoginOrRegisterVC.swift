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
        btn.setTitle("Login", for: .normal)
        btn.backgroundColor = UIColor.systemBlue
        return btn
    }()
    let registerBtn:UIButton={
        let btn = UIButton()
        btn.setTitle("Register", for: .normal)
        btn.backgroundColor = UIColor.systemBlue
        return btn
    }()
    let txt : UITextView = {
        let txt = UITextView()
        txt.text = "Register or login to receive updates and notifications regarding your subjects"
        txt.font = UIFont.systemFont(ofSize: 20)
        txt.textAlignment = .center
        txt.isEditable = false
        return txt
    }()
    let logOutBtn:UIButton={
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Logout", for: .normal)
        btn.backgroundColor = UIColor.systemBlue
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
    
    override func viewDidLoad() {
    super.viewDidLoad()
        if #available(iOS 13.0, *) {
            view.backgroundColor = UIColor.systemBackground
        } else {
            view.backgroundColor = .white
        }
    }
    func setupViewsForNoUserSignedIn(){
        let stack = UIStackView(arrangedSubviews: [image,loginBtn,registerBtn,txt])
        txt.text = nil
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        stackNoUserTopConstraint = stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        stackNoUserTopConstraint?.isActive = true
        stackNoUserleadingConstraint = stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10)
        stackNoUserleadingConstraint?.isActive = true
        stackNoUserTrailingConstraint = stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10)
        stackNoUserTrailingConstraint?.isActive = true
        stackNoUserbottomConstraint = stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        stackNoUserbottomConstraint?.isActive = true
        
        txtNoUserHeightConstraint = txt.heightAnchor.constraint(equalToConstant: 80)
        txtNoUserHeightConstraint?.isActive = true
        
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
        
    }
    func setupViewsForSignedInUser(email:String){
        txt.text = email
        let stack = UIStackView(arrangedSubviews: [image,txt])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        view.addSubview(logOutBtn)
        
        logOutBtnTopConstraint =  logOutBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        logOutBtnTopConstraint?.isActive = true
        logOutBtnTrailingConstraint = logOutBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        logOutBtnTrailingConstraint?.isActive = true
        logOutBtnWidthConstraint = logOutBtn.widthAnchor.constraint(equalToConstant: 70)
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
        registerBtnHeightConstraint = registerBtn.heightAnchor.constraint(equalToConstant: 0)
        registerBtnHeightConstraint?.isActive = true
        logInBtnHeightConstraint = loginBtn.heightAnchor.constraint(equalToConstant: 0)
        logInBtnHeightConstraint?.isActive = true
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
}
