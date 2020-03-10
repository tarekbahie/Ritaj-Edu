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
        lbl.textColor = .black
        lbl.font = UIFont.italicSystemFont(ofSize: 18)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    let label2 : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.italicSystemFont(ofSize: 18)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    let label3 : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.italicSystemFont(ofSize: 18)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    let label4 : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.italicSystemFont(ofSize: 18)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    let label5 : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.italicSystemFont(ofSize: 18)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    let label6 : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.italicSystemFont(ofSize: 18)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    let label7 : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.italicSystemFont(ofSize: 18)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    let label8 : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.italicSystemFont(ofSize: 18)
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
        let stack = UIStackView(arrangedSubviews: [stack1,stack2,stack3,stack4])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        stack.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        stack.widthAnchor.constraint(equalToConstant: safeAreaLayoutGuide.layoutFrame.width).isActive = true
        stack.heightAnchor.constraint(equalToConstant: safeAreaLayoutGuide.layoutFrame.height).isActive = true
    }
    func configureCell(name:String,age:String,sName:String,sGrade:String,s1:String,s2:String,s21:String,s22:String){
        label1.text = "Name : \n\(name)"
        label2.text = "Age: \n\(age)"
        label3.text = "School Name : \n\(sName)"
        label4.text = "Grade: \n\(sGrade)"
        label5.text = "Subject 1: \n\(s1)"
        label6.text = "Subject 2: \n\(s2)"
        if s21 != "", s22 != ""{
            label7.text = "SAT II Subject 1: \n\(s21)"
            label8.text = "SAT II Subject 2: \n\(s22)"
        }
    }
    
}
