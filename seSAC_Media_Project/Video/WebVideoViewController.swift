//
//  WebVideoViewController.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/13/24.
//

import UIKit
import WebKit

class WebVideoViewController: UIViewController,WKUIDelegate {

    var webView: WKWebView!
    var urlId: String = ""
    override func loadView() {
            let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            webView.uiDelegate = self
            view = webView
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("테스트",urlId)
        guard let youtubeUrl = URL(string:"https://www.youtube.com/watch?v=\(urlId)")else{
            print("해당 id가 없습니다")
            return
        }
        
        let myRequest = URLRequest(url: youtubeUrl)
               webView.load(myRequest)
       
    }

}
