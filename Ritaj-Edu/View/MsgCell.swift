//
//  MsgCell.swift
//  Ritaj-Edu
//
//  Created by tarek bahie on 3/5/20.
//  Copyright © 2020 tarek bahie. All rights reserved.
//

import UIKit
class MsgCell : UICollectionViewCell{
    let label1 : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.italicSystemFont(ofSize: 18)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let label2 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
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
        addSubview(label1)
        addSubview(label2)
        
        label1.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label1.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label1.widthAnchor.constraint(equalToConstant: 90).isActive = true
        label1.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        label2.topAnchor.constraint(equalTo: label1.bottomAnchor,constant: 10).isActive = true
        label2.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        label2.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        label2.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    func configureCell(subj:String,msg:String){
        label1.text = subj
        label2.text = msg
        
    }
}
