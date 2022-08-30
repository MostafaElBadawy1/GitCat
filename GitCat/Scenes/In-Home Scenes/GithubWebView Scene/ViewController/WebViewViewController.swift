//
//  WebViewViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 30/08/2022.
//
import UIKit
import WebKit
class WebViewViewController: UIViewController {
    let webView = WKWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        navigationItem.largeTitleDisplayMode = .never
        guard let gitHubUrl = URL(string: "https://github.com/") else {
            return 
        }
        webView.load(URLRequest(url: gitHubUrl))
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
}
