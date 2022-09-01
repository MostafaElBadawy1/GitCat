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
    var isMyRepo = false
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        navigationItem.largeTitleDisplayMode = .never
        guard let gitHubUrl = URL(string: "https://github.com/") else {
            return
        }
        guard let myRepoUrl = URL(string: "https://github.com/MostafaElBadawy1/GitCat") else {
            return
        }
        if isMyRepo == true {
            webView.load(URLRequest(url: myRepoUrl))
        } else {
            webView.load(URLRequest(url: gitHubUrl))
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
}
