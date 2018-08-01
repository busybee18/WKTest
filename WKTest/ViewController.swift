//
//  ViewController.swift
//  WKTest
//
//  Created by Divya Nayak on 31/07/18.
//  Copyright © 2018 Divya Nayak. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let configuration = getWebConfiguration()
        setUpWebView(withConfiguration: configuration)
        loadRequest()
    }
    
    func loadRequest() {
        let request = URLRequest(url: URL(string: "https://medium.com/")!)
        self.webView.load(request)
    }
    
    func setUpWebView(withConfiguration configuration: WKWebViewConfiguration) {
        self.webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        let height = NSLayoutConstraint(item: webView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: -44)
        let width = NSLayoutConstraint(item: webView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
        view.addConstraints([height, width])
    }
    
    func getWebConfiguration() -> WKWebViewConfiguration {
        let configuration = WKWebViewConfiguration()
        let scriptURL = Bundle.main.path(forResource: "Custom", ofType: "js")
        let scriptSource = try! String(contentsOfFile: scriptURL!, encoding: String.Encoding.utf8)
        let script = WKUserScript(source: scriptSource, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let userContentController = WKUserContentController()
        userContentController.addUserScript(script)
        configuration.userContentController = userContentController
        return configuration
    }

}

