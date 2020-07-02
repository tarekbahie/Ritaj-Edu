//
//  StudentCell.swift
//  Ritaj-Edu
//
//  Created by tarek bahie on 3/3/20.
//  Copyright © 2020 tarek bahie. All rights reserved.
//

import UIKit
class StudentCell:UICollectionViewCell{
    let label1 : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "retajBlue")
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    let label2 : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "retajBlue")
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    let label3 : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "retajBlue")
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    let label4 : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "retajBlue")
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    let label5 : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "retajBlue")
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    let label6 : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "retajBlue")
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    let label7 : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "retajBlue")
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    let label8 : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "retajBlue")
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    let label9 : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "retajBlue")
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    let label10 : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "retajBlue")
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    let label11 : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "retajBlue")
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    let label12 : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "retajBlue")
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    let label13 : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "retajBlue")
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    let label14 : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "retajBlue")
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    let label15 : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "retajBlue")
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    let label16 : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "retajBlue")
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    let label17 : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "retajBlue")
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        layer.borderWidth = 3
        if #available(iOS 13.0, *) {
            layer.borderColor = UIColor.systemGray2.cgColor
        } else {
            layer.borderColor = UIColor.black.cgColor
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
        let stack1 = UIStackView(arrangedSubviews: [label1,label2])
        stack1.axis = .horizontal
        stack1.distribution = .fillEqually
        stack1.spacing = 10
        let stack2 = UIStackView(arrangedSubviews: [label3,label4])
        stack2.axis = .horizontal
        stack2.distribution = .fillEqually
        stack2.spacing = 10
        let stack3 = UIStackView(arrangedSubviews: [label5,label6])
        stack3.axis = .horizontal
        stack3.distribution = .fillEqually
        stack3.spacing = 10
        let stack4 = UIStackView(arrangedSubviews: [label7,label8])
        stack4.axis = .horizontal
        stack4.distribution = .fillEqually
        stack4.spacing = 10
        let stack5 = UIStackView(arrangedSubviews: [label9,label10])
        stack5.axis = .horizontal
        stack5.distribution = .fillEqually
        stack5.spacing = 10
        let stack6 = UIStackView(arrangedSubviews: [label11,label12])
        stack6.axis = .horizontal
        stack6.distribution = .fillEqually
        stack6.spacing = 10
        let stack7 = UIStackView(arrangedSubviews: [label13,label14,label15])
        stack7.axis = .horizontal
        stack7.distribution = .fillEqually
        stack7.spacing = 10
        let stack = UIStackView(arrangedSubviews: [stack1,stack2,stack3,stack4,stack5,stack6,stack7,label17,label16])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        stack.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        stack.widthAnchor.constraint(equalToConstant: safeAreaLayoutGuide.layoutFrame.width).isActive = true
        stack.heightAnchor.constraint(equalToConstant: safeAreaLayoutGuide.layoutFrame.height).isActive = true
    }
    fileprivate func setupFont(_ size: String?) {
        if let s = size, s == "ipad"{
            label1.font = UIFont.systemFont(ofSize: 36)
            label2.font = UIFont.systemFont(ofSize: 36)
            label3.font = UIFont.systemFont(ofSize: 36)
            label4.font = UIFont.systemFont(ofSize: 36)
            label9.font = UIFont.systemFont(ofSize: 36)
            label5.font = UIFont.systemFont(ofSize: 36)
            label6.font = UIFont.systemFont(ofSize: 36)
            label7.font = UIFont.systemFont(ofSize: 36)
            label8.font = UIFont.systemFont(ofSize: 36)
            label10.font = UIFont.systemFont(ofSize: 36)
            label11.font = UIFont.systemFont(ofSize: 36)
            label12.font = UIFont.systemFont(ofSize: 36)
            label13.font = UIFont.systemFont(ofSize: 36)
            label14.font = UIFont.systemFont(ofSize: 36)
            label15.font = UIFont.systemFont(ofSize: 36)
        }else{
            label1.font = UIFont.systemFont(ofSize: 18)
            label2.font = UIFont.systemFont(ofSize: 18)
            label3.font = UIFont.systemFont(ofSize: 18)
            label4.font = UIFont.systemFont(ofSize: 18)
            label9.font = UIFont.systemFont(ofSize: 18)
            label5.font = UIFont.systemFont(ofSize: 18)
            label6.font = UIFont.systemFont(ofSize: 18)
            label7.font = UIFont.systemFont(ofSize: 18)
            label8.font = UIFont.systemFont(ofSize: 18)
            label10.font = UIFont.systemFont(ofSize: 18)
            label11.font = UIFont.systemFont(ofSize: 18)
            label12.font = UIFont.systemFont(ofSize: 18)
            label13.font = UIFont.systemFont(ofSize: 18)
            label14.font = UIFont.systemFont(ofSize: 18)
            label15.font = UIFont.systemFont(ofSize: 18)
        }
    }
    
    func configureCell(name:String,age:String,sName:String,sGrade:String,mob:String,mail:String,fathName:String,fathNum:String,mothName:String,mothNum:String,s11:String,s12:String,s21:String?,s22:String?,s23:String?,payments:String?,ref:String,size:String?){
        label1.text = name
        label2.text = age
        label3.text = sName
        label4.text = sGrade
        label5.text = mob
        label6.text = mail
        label7.text = fathName
        label8.text = fathNum
        label9.text = mothName
        label10.text = mothNum
        label11.text = s11
        label12.text = s12
        label17.text = ref
        if let sat21 = s21{
            label13.text = sat21
        }else{
            label13.text = nil
        }
        if let sat22 = s22{
            label14.text = sat22
        }else{
            label14.text = nil
        }
        if let sat23 = s23{
            label15.text = sat23
        }else{
            label15.text = nil
        }
        if let p = payments{
            label16.text = p
        }
        setupFont(size)
    }
    func configureCellForTeachers(name:String,age:String,sName:String,sGrade:String,mob:String,mail:String,payments:String?,size:String?){
        label1.text = name
        label2.text = age
        label3.text = sName
        label4.text = sGrade
        label5.text = mob
        label6.text = mail
        if let p = payments{
            label16.text = p
        }
        label7.isHidden = true
        label8.isHidden = true
        label9.isHidden = true
        label10.isHidden = true
        label11.isHidden = true
        label12.isHidden = true
        label13.isHidden = true
        label14.isHidden = true
        label15.isHidden = true
        label17.isHidden = true
        setupFont(size)
    }
}
