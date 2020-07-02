//
//  ComposeTeacherMsgView.swift
//  Ritaj-Edu
//
//  Created by tarek bahie on 6/29/20.
//  Copyright © 2020 tarek bahie. All rights reserved.
//

import UIKit
class ComposeTeacherMsgView:UIView,UIPickerViewDelegate,UITextViewDelegate{
    let msgLbl:UILabel={
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.text = "Type notification body"
        return lbl
    }()
    lazy var bodyTxt:UITextView={
        let txt = UITextView()
        txt.autocorrectionType = .no
        txt.autocapitalizationType = .sentences
//        txt.textAlignment = .center
        txt.text = "Enter your message here !"
        txt.delegate = self
        txt.isUserInteractionEnabled = true
        txt.isEditable = true
        txt.layer.borderWidth = 2
        txt.backgroundColor = UIColor(named: "retajBlue")
        return txt
    }()
    lazy var sendBtn:UIButton={
        let btn = UIButton()
        btn.setTitle("Send", for: .normal)
        btn.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        btn.layer.borderWidth = 2
        btn.layer.cornerRadius = 25
        btn.layer.masksToBounds = true
        return btn
    }()
    var home:TeacherVC?
    var canSetupViews:Bool?{
        didSet{
            setupViews()
        }
    }
    var size:String?{
        didSet{
            setupFontSize()
        }
    }
    var subjHeightConst:NSLayoutConstraint?
    var msgHeightConst:NSLayoutConstraint?
    var sendHeightConst:NSLayoutConstraint?
    var bodyHeightConst:NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        print("frame",frame.height)
        backgroundColor = UIColor(named: "retajBlue")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
    func setupViews(){
    let stack = UIStackView(arrangedSubviews: [msgLbl,bodyTxt,sendBtn])
        stack.distribution = .equalCentering
        stack.axis = .vertical
        stack.spacing = 20.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        
        stack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stack.heightAnchor.constraint(equalToConstant: safeAreaLayoutGuide.layoutFrame.height).isActive = true
        
        msgHeightConst = msgLbl.heightAnchor.constraint(equalToConstant: 0)
        msgHeightConst?.isActive = true
        sendHeightConst = sendBtn.heightAnchor.constraint(equalToConstant: 0)
        sendHeightConst?.isActive = true
        bodyHeightConst = bodyTxt.heightAnchor.constraint(equalToConstant: 0)
        bodyHeightConst?.isActive = true
    }
    @objc func handleSend(){
        if let text = bodyTxt.text, text != ""{
            home?.canRemoveComposeView = true
            home?.notifMsg = text
        }else{
            home?.errorSendingNotif = true
        }
        
    }
    func setupFontSize(){
        guard let _ = size else{
            msgLbl.font = UIFont.systemFont(ofSize: 20)
            bodyTxt.font = UIFont.systemFont(ofSize: 20)
            sendBtn.setAttributedTitle(NSAttributedString(string: "Send", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]), for: .normal)
            subjHeightConst?.constant = 20
            msgHeightConst?.constant = 20
            sendHeightConst?.constant = 50
            bodyHeightConst?.constant = 100
            return
        }
        msgLbl.font = UIFont.systemFont(ofSize: 30)
        bodyTxt.font = UIFont.systemFont(ofSize: 30)
        sendBtn.setAttributedTitle(NSAttributedString(string: "Send", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 30)]), for: .normal)
        subjHeightConst?.constant = 40
        msgHeightConst?.constant = 40
        sendHeightConst?.constant = 100
        bodyHeightConst?.constant = 200
        
    }
}

