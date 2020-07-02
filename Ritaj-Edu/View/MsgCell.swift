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
        lbl.textColor = UIColor(named: "retajBlue")
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let label2 : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "retajBlue")
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
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

    func configCellForAdmin(subj:String,msg:String,size:String?){
        setupViewsForAdmin()
        label1.text = subj
        label2.text = msg
        if let s = size, s == "ipad"{
            label1.font = UIFont.systemFont(ofSize: 36)
            label2.font = UIFont.systemFont(ofSize: 36)
        }else{
            label1.font = UIFont.systemFont(ofSize: 18)
            label2.font = UIFont.systemFont(ofSize: 18)
        }
    }
    func setupViewsForAdmin(){
        addSubview(label1)
        addSubview(label2)
        label1.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label1.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10).isActive = true
        label1.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10).isActive = true
        label1.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        label2.topAnchor.constraint(equalTo: label1.bottomAnchor,constant: 10).isActive = true
        label2.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10).isActive = true
        label2.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10).isActive = true
        label2.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10).isActive = true
    }
}
class NotifCell:MsgCell{
    override func configCellForAdmin(subj: String, msg: String, size: String?) {
        setupViewsForAdmin()
        label1.text = "\(subj)"
        if let s = size, s == "ipad"{
            label1.font = UIFont.systemFont(ofSize: 36)
        }else{
            label1.font = UIFont.systemFont(ofSize: 18)
        }
    }
    override func setupViewsForAdmin() {
        addSubview(label1)
        label1.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label1.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label1.widthAnchor.constraint(equalToConstant: safeAreaLayoutGuide.layoutFrame.width / 2).isActive = true
        label1.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
