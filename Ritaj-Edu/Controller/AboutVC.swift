//
//  FirstViewController.swift
//  Ritaj-Edu
//
//  Created by tarek bahie on 3/2/20.
//  Copyright © 2020 tarek bahie. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {
    let image : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "retaj")
        img.contentMode = .scaleAspectFit
        return img
    }()
    let txt : UITextView = {
        let txt = UITextView()
        txt.text = "Retaj Center The first leading center in Egypt serves all issues related to American Diploma : SAT I ( Math , English) and SAT II (physics , Biology , Math SAT II , chemistry) and CollegeBoard questions."
        txt.textAlignment = .justified
        txt.isEditable = false
        txt.backgroundColor = UIColor(named: "retajGreen")
        txt.textColor = UIColor(named: "retajBlue")
        return txt
    }()
    var size:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        self.navigationItem.title = "About"
        view.backgroundColor = UIColor(named: "retajGreen")
        switch (traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass) {
        case (.regular, .regular):
            setupRegularRegular()
            break
        default: setupFontSize()
        }
        
    }
    func setupViews(){
        let stack = UIStackView(arrangedSubviews: [image,txt])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        stack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10).isActive = true
        stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10).isActive = true
        stack.heightAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.height / 1.5).isActive = true
        image.heightAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.height / 3).isActive = true
        
    }
    func setupRegularRegular(){
        size = "ipad"
        DataService.instance.size = size
        setupFontSize()
    }
    func setupFontSize(){
        if let s = size, s == "ipad"{
            txt.font = UIFont.systemFont(ofSize: 40)
        }else{
            txt.font = UIFont.systemFont(ofSize: 20)
        }
    }

}

