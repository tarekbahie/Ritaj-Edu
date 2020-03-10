//
//  CenterAnnouncementsVC.swift
//  Ritaj-Edu
//
//  Created by tarek bahie on 3/3/20.
//  Copyright © 2020 tarek bahie. All rights reserved.
//

import UIKit
class CenterAnnouncementsVC: UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,UICollectionViewDelegate {
    lazy var collectionView : UICollectionView = {
        let lay = UICollectionViewFlowLayout()
        let cView = UICollectionView(frame: .zero, collectionViewLayout: lay)
        cView.dataSource = self
        cView.delegate = self
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.backgroundColor = UIColor.systemTeal
        return cView
    }()
    let closeBtn:UIButton={
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            btn.setImage(UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate), for: .normal)
        } else {
            btn.setImage(UIImage(named: "close")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        btn.tintColor = .black
        btn.backgroundColor = UIColor.systemBlue
        btn.layer.cornerRadius = 25.0
        return btn
    }()
    var s = [String]()
    var m = [String](){
        didSet{
            collectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MsgCell.self, forCellWithReuseIdentifier: "msgCell")
        closeBtn.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        if #available(iOS 13.0, *) {
            view.backgroundColor = UIColor.systemBackground
        } else {
            view.backgroundColor = .white
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.getStudentsNotifications { (subjs, msgs) in
            self.s = subjs
            self.m = msgs
        }
        setupViews()
        setupCloseBtnView()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        m.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "msgCell", for: indexPath) as! MsgCell
        cell.configureCell(subj: s[indexPath.item], msg: m[indexPath.item])
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
    func setupCloseBtnView(){
        view.addSubview(closeBtn)
        closeBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 5).isActive = true
        closeBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -5).isActive = true
        closeBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        closeBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    @objc func handleClose(){
        self.dismiss(animated: true, completion: nil)
    }
}
