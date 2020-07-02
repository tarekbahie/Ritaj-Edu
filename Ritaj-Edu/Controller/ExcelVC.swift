//
//  excelVC.swift
//  Ritaj-Edu
//
//  Created by tarek bahie on 7/2/20.
//  Copyright © 2020 tarek bahie. All rights reserved.
//

import UIKit
import WebKit
class ExcelVC: UIViewController, WKUIDelegate {
    
    lazy var webView: WKWebView={
        let wView = WKWebView()
        wView.uiDelegate = self
        return wView
    }()
    
    var request:NSURLRequest?
    var fileP:String?
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let r = request{
            loadURL(request: r)
        }
    }
    func loadURL(request : NSURLRequest){
        webView.load(request as URLRequest)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(self.shareCSVFile))
    }
    @objc func shareCSVFile(){
        if let path = fileP{
            let fileURL = NSURL(fileURLWithPath: path)
            var filesToShare = [Any]()
            filesToShare.append(fileURL)
            let activityViewController = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
}


