//
//  SecondViewController.swift
//  Ritaj-Edu
//
//  Created by tarek bahie on 3/2/20.
//  Copyright © 2020 tarek bahie. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginVC: UIViewController,UITextFieldDelegate {
    let image : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "retaj")
        img.contentMode = .scaleAspectFit
        return img
    }()
    let emailTxtField : UITextField = {
        let txt = UITextField()
        txt.backgroundColor = UIColor(named: "retajBlue")
        txt.autocapitalizationType = .none
        return txt
    }()
    let passTxtField : UITextField = {
        let txt = UITextField()
        txt.backgroundColor = UIColor(named: "retajBlue")
        txt.isSecureTextEntry = true
        txt.autocapitalizationType = .none
        return txt
    }()
    let loginBtn:UIButton={
        let btn = UIButton()
        btn.backgroundColor = UIColor(named: "retajBlue")
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
        btn.backgroundColor = UIColor(named: "retajBlue")
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        closeBtn.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        view.backgroundColor = UIColor(named: "retajGreen")
    }
    var stackHeightAnc : NSLayoutConstraint?
    var emailHeightAnc : NSLayoutConstraint?
    var passwHeightAnc : NSLayoutConstraint?
    var loginHeightAnc : NSLayoutConstraint?
    var closeBtnHeightAnc : NSLayoutConstraint?
    var closeBtnWidthtAnc : NSLayoutConstraint?
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupViews()
        setupCloseBtnView()
        setupFontSize()
        emailTxtField.delegate = self
        passTxtField.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        loginBtn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }
    func setupViews(){
        let stack = UIStackView(arrangedSubviews: [emailTxtField,passTxtField,loginBtn])
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        view.addSubview(image)
        
        image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10).isActive = true
        image.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        image.heightAnchor.constraint(equalToConstant: 200).isActive = true
        image.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        stack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        stack.widthAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.width - 20).isActive = true
        stackHeightAnc = stack.heightAnchor.constraint(equalToConstant: 0)
        stackHeightAnc?.isActive = true
        
        emailHeightAnc = emailTxtField.heightAnchor.constraint(equalToConstant: 0)
        emailHeightAnc?.isActive = true
        passwHeightAnc = passTxtField.heightAnchor.constraint(equalToConstant: 0)
        passwHeightAnc?.isActive = true
        loginHeightAnc = loginBtn.heightAnchor.constraint(equalToConstant: 0)
        loginHeightAnc?.isActive = true
        
    }
    @objc func handleTap(){
        emailTxtField.resignFirstResponder()
        passTxtField.resignFirstResponder()
    }
    @objc func handleLogin(){
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.setDefaultAnimationType(.native)
        SVProgressHUD.setHapticsEnabled(true)
        if let e = emailTxtField.text , e != "", let p = passTxtField.text, p != "" {
            SVProgressHUD.show()
            Auth.auth().signIn(withEmail: e.lowercased(), password: p) { (res, err) in
                if let signinErr = err{
                    SVProgressHUD.dismiss()
                    self.showAlert(msg: signinErr.localizedDescription, title: "Error signing in", signIn: nil)
                }else{
                    SVProgressHUD.dismiss()
//                    let pushManager = PushNotificationManager(userID: e)
//                    pushManager.registerForPushNotifications()
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }else{
            showAlert(msg: "Please check email and password fields", title: "Missing data", signIn: nil)
        }
        
    }
    func showAlert(msg:String,title:String,signIn:Bool?){
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
        closeBtnHeightAnc = closeBtn.heightAnchor.constraint(equalToConstant: 0)
        closeBtnHeightAnc?.isActive = true
        closeBtnWidthtAnc = closeBtn.widthAnchor.constraint(equalToConstant: 0)
        closeBtnWidthtAnc?.isActive = true
    }
    @objc func handleClose(){
        self.dismiss(animated: true, completion: nil)
    }
    func setupFontSize(){
        guard let _ = DataService.instance.size else{
            closeBtnHeightAnc?.constant = 50
            closeBtnWidthtAnc?.constant = 50
            loginHeightAnc?.constant = 40
            passwHeightAnc?.constant = 40
            emailHeightAnc?.constant = 40
            stackHeightAnc?.constant = 140
            emailTxtField.attributedPlaceholder = NSAttributedString(string: "Enter your Email", attributes: [NSAttributedString.Key.font :UIFont.systemFont(ofSize: 20)])
            passTxtField.attributedPlaceholder = NSAttributedString(string: "Enter your Password", attributes: [NSAttributedString.Key.font :UIFont.systemFont(ofSize: 20)])
            loginBtn.setAttributedTitle(NSAttributedString(string: "Login", attributes: [NSAttributedString.Key.font :UIFont.systemFont(ofSize: 20) ]), for: .normal)
            closeBtn.layer.cornerRadius = 25.0
            return
        }
        closeBtnHeightAnc?.constant = 50
        closeBtnWidthtAnc?.constant = 50
        loginHeightAnc?.constant = 80
        passwHeightAnc?.constant = 80
        emailHeightAnc?.constant = 80
        stackHeightAnc?.constant = 280
        emailTxtField.attributedPlaceholder = NSAttributedString(string: "Enter your Email", attributes: [NSAttributedString.Key.font :UIFont.systemFont(ofSize: 40)])
        passTxtField.attributedPlaceholder = NSAttributedString(string: "Enter your Password", attributes: [NSAttributedString.Key.font :UIFont.systemFont(ofSize: 40)])
        loginBtn.setAttributedTitle(NSAttributedString(string: "Login", attributes: [NSAttributedString.Key.font :UIFont.systemFont(ofSize: 40) ]), for: .normal)
        closeBtn.layer.cornerRadius = 25.0
        
    }

}

