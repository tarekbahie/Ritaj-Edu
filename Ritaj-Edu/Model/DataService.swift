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
//var ref: DocumentReference? = nil
class DataService{
    static let instance = DataService()
    var subjects = ["","Password","SATI Math","SATI English","SATII Math","SATII Physics","SATII Chemistry","SATII Biology","General"]
    var size:String?
    func getStudentsUpdatedData(comp :@escaping (_ names : [String],_ ages : [String],_ schoolNames : [String],_ schoolGrades : [String],_ mobiles:[String],_ fathers : [String],_ mothers : [String],_ emails : [String],_ fathersNum : [String],_ mothersNum : [String],_ sat11Subs : [String],_ sat12Subs : [String],_ sat21Subs : [String]?,_ sat22Subs : [String]?,_ sat23Subs : [String]?,_ payment:[String]?,_ referals:[String],_ tokens :[String])->()){
        var n = [String]()
        var a = [String]()
        var sN = [String]()
        var sG = [String]()
        var mob = [String]()
        var fathers = [String]()
        var mothers = [String]()
        var e = [String]()
        var fathersNum = [String]()
        var mothersNum = [String]()
        var sat11subs = [String]()
        var sat12Subs = [String]()
        var s21Subs = [String]()
        var s22Subs = [String]()
        var s23Subs = [String]()
        var payments = [String]()
        var referals = [String]()
        var tokens = [String]()
        db.collection("Students").getDocuments { (querySnapshot, err) in
            if let error = err{
                print(error.localizedDescription)
            }else{
                for document in querySnapshot!.documents{
                    let docData = document.data()
                    guard let fn = docData["Full Name"],let age = docData["Age"],let schoolName = docData["School Name"],let schoolGrade = docData["School Grade"],let mobile = docData["Mobile"], let fathN = docData["Father Name"], let mothN = docData["Mother Name"],let sat11 = docData["Sat 1 Sub 1"],let sat12 = docData["Sat 1 Sub 2"],let email = docData["Email"],let fathNum = docData["Father Number"],let mothNum = docData["Mother Number"],let s21 = docData["Sat 2 Sub 1"],let s22 = docData["Sat2 Sub 2"],let s23 = docData["Sat2 Sub 3"],let referal = docData["Refered by"] else{
                        return
                    }
                    n.append(fn as! String)
                    a.append(age as! String)
                    sN.append(schoolName as! String)
                    sG.append(schoolGrade as! String)
                    mob.append(mobile as! String)
                    fathers.append(fathN as! String)
                    mothers.append(mothN as! String)
                    sat11subs.append(sat11 as! String)
                    sat12Subs.append(sat12 as! String)
                    e.append(email as! String)
                    fathersNum.append(fathNum as! String)
                    mothersNum.append(mothNum as! String)
                        s21Subs.append(s21 as! String)
                        s22Subs.append(s22 as! String)
                        s23Subs.append(s23 as! String)
                    if let token = docData["fcmToken"]{
                        tokens.append(token as! String)
                    }else{
                        tokens.append("")
                    }
                    if let pay = docData["Payment"]{
                     payments.append(pay as! String)
                    }
                    referals.append(referal as! String)
                }
                comp(n,a,sN,sG,mob,fathers,mothers,e,fathersNum,mothersNum,sat11subs,sat12Subs,s21Subs,s22Subs,s23Subs,payments, referals,tokens)
            }
        }
    }
    func sendStudentUpdatedData(fN:String,a:String,sN:String,sG:String,sat1:String,sat2:String,email:String,s21Sub:String?,s22Sub:String?,refer:String,referal:String,comp : @escaping(_ success : Bool, _ errMsg:String?)->()){
        if let s21 = s21Sub,let s22 = s22Sub{
            let ref = db.collection("Students").document(email)
            ref.setData(["Full Name": fN,"Age": a,"School Name": sN,"School Grade": sG,"Mobile":refer,"Father Name": sat1,"Mother Name": sat2,"Email": email,"Father Number":s21,"Mother Number":s22,"Refered by":referal,"Payment":"Pending"]) { (error) in
                if let err = error{
                    comp(false,err.localizedDescription)
                }else{
                    comp(true,nil)
                }
            }
        }else{
            let ref = db.collection("Students").document(email)
            ref.setData(["Full Name": fN,"Age": a,"School Name": sN,"School Grade": sG,"Mobile":refer,"Father Name": sat1,"Mother Name": sat2,"Email": email,"Payment":"Pending"]) { (error) in
                if let err = error{
                    comp(false,err.localizedDescription)
                }else{
                    comp(true,nil)
                }
            }
        }
    }
    func sendNotificationsToStudents(senderName:String,subject:String,notif:String,time:Timestamp,comp: @escaping(_ success : Bool, _ errMsg:String?)->()){
        let ref = db.collection("Notifications").document(senderName).collection(subject).document()
        ref.setData(["Subject":subject,"Notification":notif,"Time":time]) { (err) in
            if let error = err {
                comp(false,error.localizedDescription)
            }else{
                print("data sent")
                comp(true,nil)
            }
        }
    }
    func getStudentsNotificationsFromAdmin(comp :@escaping (_ subjects : [String],_ msgs : [String])->()){
        var s = [String]()
        var m = [String]()
        db.collection("Notifications").document("Admin").collection("Password").order(by: "Time", descending: true).getDocuments { (querySnapshot, err) in
            if let error = err{
                print(error.localizedDescription)
                return
            }else{
            for document in querySnapshot!.documents{
            let docData = document.data()
                guard let notif = docData["Notification"],let subj = docData["Subject"] else{return}
                s.append(subj as! String)
                m.append(notif as! String)
                }
                db.collection("Notifications").document("Admin").collection("SATI Math").order(by: "Time", descending: true).getDocuments { (querySnap, err) in
                    if let error = err{
                        print(error.localizedDescription)
                        return
                    }else{
                    for document in querySnap!.documents{
                    let docData = document.data()
                        guard let notif = docData["Notification"],let subj = docData["Subject"] else{return}
                        s.append(subj as! String)
                        m.append(notif as! String)
                        }
                        comp(s,m)
                    }
                }
            }
        }
        
    }
    func getRegisteredEmails(comp :@escaping (_ names : [String]?,_ emails : [String]?,_ err:Bool?)->()){
        var n = [String]()
        var e = [String]()
        db.collection("Students").getDocuments { (querySnapshot, err) in
            if let _ = err{
                comp(nil,nil,true)
            }else{
                for document in querySnapshot!.documents{
                    let docData = document.data()
                    guard let email = docData["Email"] else{
                        return
                    }
                    if let fn = docData["Full Name"]{
                    n.append(fn as! String)
                    }else{
                        n.append("")
                    }
                    
                    e.append(email as! String)
                }
                comp(n,e,nil)
            }
        }
    }
    
    func sendSatData(sat1sub1:String,sat1sub2:String,email:String,s2Sub1:String?,s2Sub2:String?,s2Sub3:String?,comp : @escaping(_ success : Bool, _ errMsg:String?)->()){
        if let s21 = s2Sub1,let s22 = s2Sub2,let s23 = s2Sub3{
            let ref = db.collection("Students").document(email)
            ref.updateData(["Sat 1 Sub 1": sat1sub1,"Sat 1 Sub 2": sat1sub2,"Sat 2 Sub 1": s21,"Sat2 Sub 2": s22,"Sat2 Sub 3": s23]) { (error) in
                if let err = error{
                    comp(false,err.localizedDescription)
                }else{
                    comp(true,nil)
                }
            }
        }else{
            let ref = db.collection("Students").document(email)
            ref.updateData(["Sat 1 Sub 1": sat1sub1,"Sat 1 Sub 2": sat1sub2]) { (error) in
                if let err = error{
                    comp(false,err.localizedDescription)
                }else{
                    comp(true,nil)
                }
            }
        }
    }
    func updatePayment(status:String,email:String,comp : @escaping(_ success : Bool, _ errMsg:String?)->()){
        let ref = db.collection("Students").document(email)
        ref.updateData(["Payment":status]) { (error) in
            if let err = error{
                comp(false,err.localizedDescription)
            }else{
                comp(true,nil)
            }
        }
    }
    func getStudentsForTeachersWith(name:String,comp :@escaping (_ names : [String],_ ages : [String],_ schoolNames : [String],_ schoolGrades : [String],_ mobiles:[String],_ emails : [String],_ payment:[String]?,_ tokens:[String])->()){
        var n = [String]()
        var a = [String]()
        var sN = [String]()
        var sG = [String]()
        var mob = [String]()
        var e = [String]()
        var sat11subs = [String]()
        var sat12Subs = [String]()
        var s21Subs = [String]()
        var s22Subs = [String]()
        var s23Subs = [String]()
        var payments = [String]()
        var tokens = [String]()
        db.collection("Students").getDocuments { (querySnapshot, err) in
            if let error = err{
                print(error.localizedDescription)
            }else{
                for document in querySnapshot!.documents{
                    let docData = document.data()
                    guard let fn = docData["Full Name"],let age = docData["Age"],let schoolName = docData["School Name"],let schoolGrade = docData["School Grade"],let mobile = docData["Mobile"],let sat11 = docData["Sat 1 Sub 1"],let sat12 = docData["Sat 1 Sub 2"],let email = docData["Email"],let s21 = docData["Sat 2 Sub 1"],let s22 = docData["Sat2 Sub 2"],let s23 = docData["Sat2 Sub 3"] else{
                        return
                    }
                    if sat11 as! String == name || sat12 as! String == name || s21 as! String == name || s22 as! String == name || s23 as! String == name {
                        n.append(fn as! String)
                        a.append(age as! String)
                        sN.append(schoolName as! String)
                        sG.append(schoolGrade as! String)
                        mob.append(mobile as! String)
                        sat11subs.append(sat11 as! String)
                        sat12Subs.append(sat12 as! String)
                        e.append(email as! String)
                            s21Subs.append(s21 as! String)
                            s22Subs.append(s22 as! String)
                            s23Subs.append(s23 as! String)
                        if let pay = docData["Payment"]{
                         payments.append(pay as! String)
                        }
                        if let token = docData["fcmToken"]{
                            tokens.append(token as! String)
                        }else{
                            tokens.append("")
                        }
                    }
                    
                }
                comp(n,a,sN,sG,mob,e,payments,tokens)
            }
        }
    }
    func sendTeacherNotifications(teacherName:String,notif:String,time:Timestamp,comp: @escaping(_ success : Bool, _ errMsg:String?)->()){
        let ref = db.collection("Notifications").document(teacherName).collection(teacherName).document()
        ref.setData(["Notification" : notif,"Time":time]) { (err) in
            if let error = err {
                comp(false,error.localizedDescription)
            }else{
                print("data sent")
                comp(true,nil)
            }
        }
    }
    func getStudentsNotificationsFromTeacherWith(name:String,comp :@escaping (_ msgs : [String])->()){
        var m = [String]()
        print(name)
        db.collection("Notifications").document(name).collection(name).order(by: "Time", descending: true).getDocuments { (querySnap, err) in
            if let error = err{
                print(error.localizedDescription)
                return
            }else{
            for document in querySnap!.documents{
            let docData = document.data()
                guard let notif = docData["Notification"]else{return}
                m.append(notif as! String)
                }
                comp(m)
            }
        }
    }
    func getRegisteredCourses(email:String,comp: @escaping(_ courses:[String])->()){
        var courses = [String]()
        db.collection("Students").getDocuments { (querySnapshot, err) in
            if let error = err{
                print("error",error.localizedDescription)
            }else{
                for document in querySnapshot!.documents{
                    let docData = document.data()
                    guard let mail = docData["Email"],let sat11 = docData["Sat 1 Sub 1"],let sat12 = docData["Sat 1 Sub 2"],let sat21 = docData["Sat 2 Sub 1"],let sat22 = docData["Sat2 Sub 2"],let sat23 = docData["Sat2 Sub 3"] else{
                        return
                    }
                    if mail as! String == email{
                        courses.append(sat11 as! String)
                        courses.append(sat12 as! String)
                        courses.append(sat21 as! String)
                        courses.append(sat22 as! String)
                        courses.append(sat23 as! String)
                    }
                }
                comp(courses)
            }
        }
    }
}
