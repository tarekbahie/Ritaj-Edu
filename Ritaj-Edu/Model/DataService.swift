//
//  DataService.swift
//  Ritaj-Edu
//
//  Created by tarek bahie on 3/3/20.
//  Copyright © 2020 tarek bahie. All rights reserved.
//

import Foundation
import Firebase


let db = Firestore.firestore()
var ref: DocumentReference? = nil
class DataService{
    static let instance = DataService()
    
    func getStudentsUpdatedData(comp :@escaping (_ names : [String],_ ages : [String],_ schoolNames : [String],_ schoolGrades : [String],_ sat1Subs : [String],_ sat2Subs : [String],_ emails : [String],_ sat21Subs : [String]?,_ sat22Subs : [String]?)->()){
        var n = [String]()
        var a = [String]()
        var sN = [String]()
        var sG = [String]()
        var s1Subs = [String]()
        var s2Subs = [String]()
        var e = [String]()
        var s21Subs = [String]()
        var s22Subs = [String]()
        db.collection("Students").getDocuments { (querySnapshot, err) in
            if let error = err{
                print(error.localizedDescription)
            }else{
                for document in querySnapshot!.documents{
                    let docData = document.data()
                    guard let fn = docData["Full Name"],let age = docData["Age"],let schoolName = docData["School Name"],let schoolGrade = docData["School Grade"], let sat1 = docData["Subject 1"], let sat2 = docData["Subject 2"],let email = docData["Email"] else{
                        return
                    }
                    n.append(fn as! String)
                    a.append(age as! String)
                    sN.append(schoolName as! String)
                    sG.append(schoolGrade as! String)
                    s1Subs.append(sat1 as! String)
                    s2Subs.append(sat2 as! String)
                    e.append(email as! String)
                    if let s21 = docData["SAT II Subject 1"],let s22 = docData["SAT II Subject 2"]{
                        s21Subs.append(s21 as! String)
                        s22Subs.append(s22 as! String)
                    }
                }
                comp(n,a,sN,sG,s1Subs,s2Subs,e,s21Subs,s22Subs)
            }
        }
    }
    func sendStudentUpdatedData(fN:String,a:String,sN:String,sG:String,sat1:String,sat2:String,email:String,s21Sub:String?,s22Sub:String?,comp : @escaping(_ success : Bool, _ errMsg:String?)->()){
        if let s21 = s21Sub,let s22 = s22Sub{
            ref = db.collection("Students").addDocument(data: ["Full Name": fN,"Age": a,"School Name": sN,"School Grade": sG,"Subject 1": sat1,"Subject 2": sat2,"Email": email,"SAT II Subject 1":s21,"SAT II Subject 2":s22], completion: { (err) in
                if let error = err{
                    print(error.localizedDescription)
                    comp(false,error.localizedDescription)
                }else{
                    print("Data Updated")
                    comp(true,nil)
                }
            })
        }else{
            ref = db.collection("Students").addDocument(data: ["Full Name": fN,"Age": a,"School Name": sN,"School Grade": sG,"Subject 1": sat1,"Subject 2": sat2,"Email": email], completion: { (err) in
                if let error = err{
                    print(error.localizedDescription)
                    comp(false,error.localizedDescription)
                }else{
                    print("Data Updated")
                    comp(true,nil)
                }
            })
        }
    }
    func sendNotificationsToStudents(subject:String,notif:String,comp: @escaping(_ success : Bool, _ errMsg:String?)->()){
        ref = db.collection("Notifications").addDocument(data: ["Subject":subject,"Notification":notif], completion: { (err) in
            if let error = err {
                comp(false,error.localizedDescription)
            }else{
                print("data sent")
                comp(true,nil)
            }
        })
    }
    func getStudentsNotifications(comp :@escaping (_ subjects : [String],_ msgs : [String])->()){
        var s = [String]()
        var m = [String]()
        db.collection("Notifications").getDocuments { (querySnapshot, error) in
            if let err = error{
                print(err.localizedDescription)
            }else{
                for document in querySnapshot!.documents {
                    let docData = document.data()
                    guard let fn = docData["Subject"],let age = docData["Notification"] else{
                        return
                    }
                    s.append(fn as! String)
                    m.append(age as! String)
                }
                comp(s,m)
            }
        }
    }
    func getRegisteredEmails(comp :@escaping (_ names : [String],_ emails : [String])->()){
        var n = [String]()
        var e = [String]()
        db.collection("Students").getDocuments { (querySnapshot, err) in
            if let error = err{
                print(error.localizedDescription)
            }else{
                for document in querySnapshot!.documents{
                    let docData = document.data()
                    guard let fn = docData["Full Name"],let email = docData["Email"] else{
                        return
                    }
                    n.append(fn as! String)
                    e.append(email as! String)
                }
                comp(n,e)
            }
        }
    }
}
