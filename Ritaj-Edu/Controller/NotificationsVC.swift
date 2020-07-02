//
//  NotificationsVC.swift
//  Ritaj-Edu
//
//  Created by tarek bahie on 6/30/20.
//  Copyright © 2020 tarek bahie. All rights reserved.
//


import UIKit
import Firebase
class NotificationsVC: UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,UICollectionViewDelegate {
    lazy var collectionView : UICollectionView = {
        let lay = UICollectionViewFlowLayout()
        let cView = UICollectionView(frame: .zero, collectionViewLayout: lay)
        cView.dataSource = self
        cView.delegate = self
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.backgroundColor = UIColor(named: "retajGreen")
        return cView
    }()
    var subject:[String]?
    var m :[String]?{
        didSet{
            collectionView.reloadData()
        }
    }
    var size:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MsgCell.self, forCellWithReuseIdentifier: "msgCell")
        if #available(iOS 13.0, *) {
            view.backgroundColor = UIColor(named: "retajGreen")
        } else {
            view.backgroundColor = UIColor(named: "retajGreen")
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        size = DataService.instance.size
        setupViews()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sub = subject{
            return sub.count
        }else if let msg = m{
            return msg.count
        }else{
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "msgCell", for: indexPath) as! MsgCell
        if let sub = subject{
            cell.configCellForAdmin(subj: sub[indexPath.item], msg: m?[indexPath.item] ?? "", size: self.size)
        }else{
            cell.configCellForAdmin(subj: m?[indexPath.item] ?? "", msg: "", size: size)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: view.safeAreaLayoutGuide.layoutFrame.height / 2)
    }
    
    func setupViews(){
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.subject = nil
        self.m = nil
    }
}
