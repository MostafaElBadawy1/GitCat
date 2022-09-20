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
    var signingIn = false
    let clintID = "a4256f5599e7f5ce4e5f"
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
        guard let signINUrl = URL(string: "https://github.com/login/oauth/authorize?redirect_uri=mostafa.GitCat://authentication&state=state&client_id=\(clintID)&scope=repo%20user") else {
            return
        }
        if signingIn == true {
            webView.load(URLRequest(url: signINUrl))
        } else {
        if isMyRepo == true {
            webView.load(URLRequest(url: myRepoUrl))
        } else {
            webView.load(URLRequest(url: gitHubUrl))
        }
    }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
}
//https://github.com/login/oauth/authorize?scope=user:email&client_id=<%=a4256f5599e7f5ce4e5f%>
