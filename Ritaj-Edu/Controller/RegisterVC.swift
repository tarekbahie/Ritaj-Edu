//
//  RegisterVC.swift
//  Ritaj-Edu
//
//  Created by tarek bahie on 3/2/20.
//  Copyright © 2020 tarek bahie. All rights reserved.
//

import UIKit
import Firebase

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
        txt.backgroundColor = UIColor.systemTeal
        txt.attributedPlaceholder = NSAttributedString(string: "Enter your Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue])
        return txt
    }()
    let passTxtField : UITextField = {
        let txt = UITextField()
        txt.backgroundColor = UIColor.systemTeal
        txt.attributedPlaceholder = NSAttributedString(string: "Enter your Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue])
        txt.isSecureTextEntry = true
        return txt
    }()
    let registerBtn:UIButton={
        let btn = UIButton()
        btn.setTitle("Register", for: .normal)
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
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupCloseBtnView()
        closeBtn.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        if #available(iOS 13.0, *) {
            view.backgroundColor = UIColor.systemBackground
        } else {
            view.backgroundColor = .white
        }
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
        stack.spacing = 10.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        view.addSubview(image)
        
        image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10).isActive = true
        image.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        image.heightAnchor.constraint(equalToConstant: 200).isActive = true
        image.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        stack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        stack.widthAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.width).isActive = true
        stack.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        emailTxtField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passTxtField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        registerBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    @objc func handleTap(){
        emailTxtField.resignFirstResponder()
        passTxtField.resignFirstResponder()
    }
    @objc func handleRegister(){
      if let e = emailTxtField.text , e != "", let p = passTxtField.text, p != "" {
        Auth.auth().createUser(withEmail: e, password: p) { (res, err) in
            if let error = err{
                self.showAlert(msg: error.localizedDescription, title: "Error registering user", signIn: nil)
            }else{
                Auth.auth().signIn(withEmail: e, password: p) { (signRes, SignErr) in
                    if let signinErr = SignErr{
                        self.showAlert(msg: signinErr.localizedDescription, title: "Error signing in", signIn: nil)
                    }else{
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                //self.showAlert(msg: "Registeration successful", title: "Success", signIn: nil)
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
        closeBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        closeBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    @objc func handleClose(){
        self.dismiss(animated: true, completion: nil)
    }
}
