//
//  FirstViewController.swift
//  Ritaj-Edu
//
//  Created by tarek bahie on 3/2/20.
//  Copyright © 2020 tarek bahie. All rights reserved.
//

import UIKit

class AboutVC: UINavigationController {
    let image : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "retaj")
        img.contentMode = .scaleAspectFit
        return img
    }()
    let txt : UITextView = {
        let txt = UITextView()
        txt.text = "Retaj Center The first leading center in Egypt serves all issues related to American Diploma : SAT I ( Math , English) and SAT II (physics , Biology , Math SAT II , chemistry) and CollegeBoard questions.\n What is SAT? \n SAT is a globally recognized college admission test that lets you show colleges what you know and how well you can apply that knowledge. It tests your knowledge of reading, writing and math — subjects that are taught every day in high school classrooms. Most students take the SAT during their junior or senior year of high school, and almost all colleges and universities use the SAT to make admission decisions.Taking the SAT is the first step in finding the right college and retaj is the place to help you achieve all your goals."
        txt.font = UIFont.systemFont(ofSize: 20)
        txt.textAlignment = .center
        txt.isEditable = false
        return txt
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        if #available(iOS 13.0, *) {
            view.backgroundColor = UIColor.systemBackground
        } else {
            view.backgroundColor = .white
        }
        
    }
    func setupViews(){
        let stack = UIStackView(arrangedSubviews: [image,txt])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10).isActive = true
        stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10).isActive = true
        stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }

}

