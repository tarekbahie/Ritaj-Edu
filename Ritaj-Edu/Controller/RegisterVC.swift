//
//  RegisterVC.swift
//  Ritaj-Edu
//
//  Created by tarek bahie on 3/2/20.
//  Copyright © 2020 tarek bahie. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterVC: UIViewController,UITextFieldDelegate {
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
        txt.placeholder = "Enter your Email"
        txt.autocapitalizationType = .none
        return txt
    }()
    let passTxtField : UITextField = {
        let txt = UITextField()
        txt.backgroundColor = UIColor(named: "retajBlue")
        txt.placeholder = "Enter your Password"
        txt.isSecureTextEntry = true
        txt.autocapitalizationType = .none
        return txt
    }()
    let registerBtn:UIButton={
        let btn = UIButton()
        btn.setTitle("Register", for: .normal)
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
        btn.layer.cornerRadius = 25.0
        return btn
    }()
    var stackHeightAnc : NSLayoutConstraint?
    var emailHeightAnc : NSLayoutConstraint?
    var passwHeightAnc : NSLayoutConstraint?
    var registerHeightAnc : NSLayoutConstraint?
    var closeBtnHeightAnc : NSLayoutConstraint?
    var closeBtnWidthtAnc : NSLayoutConstraint?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupCloseBtnView()
        setupFontSize()
        closeBtn.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        view.backgroundColor = UIColor(named: "retajGreen")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailTxtField.delegate = self
        passTxtField.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        registerBtn.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
    }
    func setupViews(){
        let stack = UIStackView(arrangedSubviews: [emailTxtField,passTxtField,registerBtn])
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
        registerHeightAnc = registerBtn.heightAnchor.constraint(equalToConstant: 0)
        registerHeightAnc?.isActive = true
        
    }
    @objc func handleTap(){
        emailTxtField.resignFirstResponder()
        passTxtField.resignFirstResponder()
    }
    @objc func handleRegister(){
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.setDefaultAnimationType(.native)
        SVProgressHUD.setHapticsEnabled(true)
      if let e = emailTxtField.text , e != "", let p = passTxtField.text, p != "" {
        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: e.lowercased(), password: p) { (res, err) in
            if let error = err{
                SVProgressHUD.dismiss()
                self.showAlert(msg: error.localizedDescription, title: "Error registering user", signIn: nil)
            }else{
                Auth.auth().signIn(withEmail: e, password: p) { (signRes, SignErr) in
                    if let signinErr = SignErr{
                        SVProgressHUD.dismiss()
                        self.showAlert(msg: signinErr.localizedDescription, title: "Error signing in", signIn: nil)
                    }else{
                        SVProgressHUD.dismiss()
//                        let pushManager = PushNotificationManager(userID: e)
//                        pushManager.registerForPushNotifications()
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                //self.showAlert(msg: "Registeration successful", title: "Success", signIn: nil)
            }
        }
        }else{
        SVProgressHUD.dismiss()
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
        closeBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        closeBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    @objc func handleClose(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupFontSize(){
        guard let _ = DataService.instance.size else{
            closeBtnHeightAnc?.constant = 50
            closeBtnWidthtAnc?.constant = 50
            registerHeightAnc?.constant = 40
            passwHeightAnc?.constant = 40
            emailHeightAnc?.constant = 40
            stackHeightAnc?.constant = 140
            emailTxtField.font = UIFont.systemFont(ofSize: 20)
            passTxtField.font = UIFont.systemFont(ofSize: 20)
            emailTxtField.attributedPlaceholder = NSAttributedString(string: "Enter your Email", attributes: [NSAttributedString.Key.font :UIFont.systemFont(ofSize: 20)])
            passTxtField.attributedPlaceholder = NSAttributedString(string: "Enter your Password", attributes: [NSAttributedString.Key.font :UIFont.systemFont(ofSize: 20)])
            registerBtn.setAttributedTitle(NSAttributedString(string: "Register", attributes: [NSAttributedString.Key.font :UIFont.systemFont(ofSize: 20) ]), for: .normal)
            closeBtn.layer.cornerRadius = 25.0
            return
        }
        closeBtnHeightAnc?.constant = 50
        closeBtnWidthtAnc?.constant = 50
        registerHeightAnc?.constant = 80
        passwHeightAnc?.constant = 80
        emailHeightAnc?.constant = 80
        stackHeightAnc?.constant = 280
        emailTxtField.font = UIFont.systemFont(ofSize: 40)
        passTxtField.font = UIFont.systemFont(ofSize: 40)
        emailTxtField.attributedPlaceholder = NSAttributedString(string: "Enter your Email", attributes: [NSAttributedString.Key.font :UIFont.systemFont(ofSize: 40)])
        passTxtField.attributedPlaceholder = NSAttributedString(string: "Enter your Password", attributes: [NSAttributedString.Key.font :UIFont.systemFont(ofSize: 40)])
        registerBtn.setAttributedTitle(NSAttributedString(string: "Register", attributes: [NSAttributedString.Key.font :UIFont.systemFont(ofSize: 40) ]), for: .normal)
        closeBtn.layer.cornerRadius = 25.0
        
    }
}
