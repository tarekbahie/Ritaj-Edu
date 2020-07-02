//
//  StudentSatDataVC.swift
//  Ritaj-Edu
//
//  Created by tarek bahie on 6/28/20.
//  Copyright © 2020 tarek bahie. All rights reserved.
//

import UIKit
import Firebase
class StudentSatDataVC: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate{
   let image : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "retaj")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    let picker1:UIPickerView={
       let pic1 = UIPickerView()
        pic1.tintColor = UIColor(named: "retajGreen")
        pic1.tag = 1
        pic1.layer.borderWidth = 1.0
        pic1.layer.borderColor = UIColor.white.cgColor
        return pic1
    }()
    let picker2:UIPickerView={
       let pic1 = UIPickerView()
        pic1.tintColor = UIColor(named: "retajGreen")
        pic1.tag = 2
        pic1.layer.borderWidth = 1.0
        pic1.layer.borderColor = UIColor.white.cgColor
        return pic1
    }()
    let picker3:UIPickerView={
       let pic1 = UIPickerView()
        pic1.tintColor = UIColor(named: "retajGreen")
        pic1.tag = 3
        pic1.layer.borderWidth = 1.0
        pic1.layer.borderColor = UIColor.white.cgColor
        return pic1
    }()
    let picker4:UIPickerView={
       let pic1 = UIPickerView()
        pic1.tintColor = UIColor(named: "retajGreen")
        pic1.tag = 4
        pic1.layer.borderWidth = 1.0
        pic1.layer.borderColor = UIColor.white.cgColor
        return pic1
    }()
    let picker5:UIPickerView={
       let pic1 = UIPickerView()
        pic1.tintColor = UIColor(named: "retajGreen")
        pic1.tag = 5
        pic1.layer.borderWidth = 1.0
        pic1.layer.borderColor = UIColor.white.cgColor
        return pic1
    }()
    let updateData:UIButton={
        let btn = UIButton()
        btn.backgroundColor = UIColor(named: "retajBlue")
        btn.setTitleColor(UIColor(named: "retajGreen"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Update Sat Data", for: .normal)
        return btn
    }()
    let txt : UITextView = {
        let txt = UITextView()
        txt.textAlignment = .center
        txt.isEditable = false
        txt.text = "Please Choose SAT II data if you are registering for SAT II only"
        txt.backgroundColor = UIColor(named: "retajGreen")
        txt.textColor = UIColor(named: "retajBlue")
        return txt
    }()
    let english = ["------","Ahmed English","Mohamed English","Mahmoud English"]
    let mathI = ["------","Ahmed Math I","Mohamed Math I","Mahmoud Math I"]
    let mathII = ["------","Ahmed Math II","Mohamed Math II","Mahmoud Math II"]
    let physics = ["------","Ahmed Physics","Mohamed Physics","Mahmoud Physics"]
    let biology = ["------","Ahmed Biology","Mohamed Biology","Mahmoud Biology"]
    var eng = ""
    var matI = ""
    var matII = ""
    var phy = ""
    var bio = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "SAT Data"
        view.backgroundColor = UIColor(named: "retajGreen")
        setupViews()
        picker1.delegate = self
        picker2.delegate = self
        picker3.delegate = self
        picker4.delegate = self
        picker5.delegate = self
        updateData.addTarget(self, action: #selector(handleSataData), for: .touchUpInside)
    }
    func setupPickerTitles(picker:UIPickerView,title:String){
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        picker.addSubview(label)
        label.topAnchor.constraint(equalTo: picker.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: picker.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: picker.trailingAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.text = title
        label.backgroundColor = UIColor(named: "retajBlue")
        label.textAlignment = .center
        label.textColor = UIColor(named: "retajGreen")
    }
    func setupViews(){
        let stack1 = UIStackView(arrangedSubviews: [picker1,picker2])
        stack1.axis = .horizontal
        stack1.distribution = .fillEqually
        stack1.spacing = 10.0
        let stack2 = UIStackView(arrangedSubviews: [picker3,picker4,picker5])
        stack2.axis = .horizontal
        stack2.distribution = .fillEqually
        stack2.spacing = 10.0
        let stack = UIStackView(arrangedSubviews: [stack1,txt,stack2])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
//        stack.spacing = 10.0
        
        view.addSubview(image)
        view.addSubview(stack)
        view.addSubview(updateData)
        
        image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10).isActive = true
        image.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10).isActive = true
        image.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10).isActive = true
        image.heightAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.height / 4).isActive = true
        
        stack.topAnchor.constraint(equalTo: image.bottomAnchor,constant: 10).isActive = true
        stack.leadingAnchor.constraint(equalTo: image.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: image.trailingAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: updateData.topAnchor,constant: -10).isActive = true
        
        updateData.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10).isActive = true
        updateData.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10).isActive = true
        updateData.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10).isActive = true
        updateData.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        txt.heightAnchor.constraint(equalToConstant: 40).isActive = true
        setupPickerTitles(picker: picker1, title: "English")
        setupPickerTitles(picker: picker2, title: "Math I")
        setupPickerTitles(picker: picker3, title: "Math II")
        setupPickerTitles(picker: picker4, title: "Physics")
        setupPickerTitles(picker: picker5, title: "Biology")
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }

//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return "First \(row)"
//    }
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            eng = english[row]
        }else if pickerView.tag == 2 {
            matI = mathI[row]
        }else if pickerView.tag == 3 {
            matII = mathII[row]
        }else if pickerView.tag == 4 {
            phy = physics[row]
        }else{
            bio = biology[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        var label: UILabel
        if let view = view as? UILabel { label = view }
        else { label = UILabel() }
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        if pickerView.tag == 1 {
            let myTitle = NSAttributedString(string: english[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "retajBlue")!])
            label.attributedText = myTitle
        }else if pickerView.tag == 2 {
            let myTitle = NSAttributedString(string: mathI[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "retajBlue")!])
            label.attributedText = myTitle
        }else if pickerView.tag == 3 {
            let myTitle = NSAttributedString(string: mathII[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "retajBlue")!])
            label.attributedText = myTitle
        }else if pickerView.tag == 4 {
            let myTitle = NSAttributedString(string: physics[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "retajBlue")!])
            label.attributedText = myTitle
        }else{
            let myTitle = NSAttributedString(string: biology[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "retajBlue")!])
            label.attributedText = myTitle
        }

        return label
    }
    @objc func handleSataData(){
//        print("Your selected data is : \(eng), \(matI),\(matII),\(bio),\(phy)")
        let mail = Auth.auth().currentUser?.email
        if mail != nil{
            DataService.instance.sendSatData(sat1sub1: eng, sat1sub2: matI, email: mail!, s2Sub1: matII, s2Sub2: phy, s2Sub3: bio) { (success, errorDesc) in
                if let err = errorDesc{
                    print(err)
                }else{
                    print("success")
                    savedSatData.set(mail!, forKey: "Saved")
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
