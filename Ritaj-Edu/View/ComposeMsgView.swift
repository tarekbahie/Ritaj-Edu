//
//  ComposeMsgView.swift
//  Ritaj-Edu
//
//  Created by tarek bahie on 3/28/20.
//  Copyright © 2020 tarek bahie. All rights reserved.
//

import UIKit
class ComposeMsgView:UIView,UIPickerViewDelegate,UIPickerViewDataSource,UITextViewDelegate{
    lazy var subjPick:UIPickerView={
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.layer.borderWidth = 2
        return picker
    }()
    let subjLbl:UILabel={
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.text = "Choose notification subject"
        return lbl
    }()
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
    var subjSelected:String?{
        didSet{
            print(subjSelected!)
        }
    }
    var home:AdminVC?
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return DataService.instance.subjects.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return DataService.instance.subjects[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.subjSelected = DataService.instance.subjects[row]
    }
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
    let stack = UIStackView(arrangedSubviews: [subjLbl,subjPick,msgLbl,bodyTxt,sendBtn])
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 20.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        stack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stack.heightAnchor.constraint(equalToConstant: (safeAreaLayoutGuide.layoutFrame.height / 2) + 150).isActive = true
        
        subjHeightConst = subjLbl.heightAnchor.constraint(equalToConstant: 0)
        subjHeightConst?.isActive = true
        msgHeightConst = msgLbl.heightAnchor.constraint(equalToConstant: 0)
        msgHeightConst?.isActive = true
        sendHeightConst = sendBtn.heightAnchor.constraint(equalToConstant: 0)
        sendHeightConst?.isActive = true
        bodyHeightConst = bodyTxt.heightAnchor.constraint(equalToConstant: 0)
        bodyHeightConst?.isActive = true
    }
    @objc func handleSend(){
        if let subj = subjSelected,subj != "", let text = bodyTxt.text, text != ""{
            home?.notifSubj = subj
            home?.canRemoveComposeView = true
            home?.notifMsg = text
        }else{
            home?.errorSendingNotif = true
        }
        
    }
    func setupFontSize(){
        guard let _ = size else{
            subjLbl.font = UIFont.systemFont(ofSize: 20)
            msgLbl.font = UIFont.systemFont(ofSize: 20)
            bodyTxt.font = UIFont.systemFont(ofSize: 20)
            sendBtn.setAttributedTitle(NSAttributedString(string: "Send", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]), for: .normal)
            subjHeightConst?.constant = 20
            msgHeightConst?.constant = 20
            sendHeightConst?.constant = 50
            bodyHeightConst?.constant = 100
            return
        }
        subjLbl.font = UIFont.systemFont(ofSize: 30)
        msgLbl.font = UIFont.systemFont(ofSize: 30)
        bodyTxt.font = UIFont.systemFont(ofSize: 30)
        sendBtn.setAttributedTitle(NSAttributedString(string: "Send", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 30)]), for: .normal)
        subjHeightConst?.constant = 40
        msgHeightConst?.constant = 40
        sendHeightConst?.constant = 100
        bodyHeightConst?.constant = 200
        
    }
}
