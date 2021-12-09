//
//  PrivacyViewController.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/15.
//

import UIKit
import WebKit

class PrivacyViewController: BaseViewController {
    
    private lazy var webView: WKWebView = {
        
        let web = WKWebView()
        
        web.navigationDelegate = self
        
        return web
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setWebView()
        
        loadURL()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    private func loadURL() {
        
        if let url = URL(string: "https://www.privacypolicies.com/live/efcb84d1-7dfa-456b-9b23-07afdeb77ef1") {
            
            let request = URLRequest(url: url)
            
            webView.load(request)
        }
    }
}

// MARK: - WKNavigationDelegate -
extension PrivacyViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Start loading")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finish loading")
    }
    
}

// MARK: - Layout -
extension PrivacyViewController {
    
    private func setWebView() {
        
        view.addSubview(webView)
        
        view.sendSubviewToBack(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
