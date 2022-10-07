//
//  SplashViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 13/09/2022.
//
import UIKit
class SplashViewController: UIViewController {
    var splashViewModel = SplashViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        appAppearanceConfig()
        if splashViewModel.isLoggedIn == true {
            let tabBarVC = UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: K.tabBarID) as! UITabBarController
            tabBarVC.modalPresentationStyle = .fullScreen
            self.present(tabBarVC, animated: false, completion: nil)
        } else {
            let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: K.loginViewControllerID) as! LoginViewController
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: false, completion: nil)
        }
    }
    func appAppearanceConfig() {
        let window = UIApplication.shared.windows[0]
        if UserDefaults.standard.bool(forKey: "isDarkMode") == true {
            window.overrideUserInterfaceStyle = .dark
        } else {
            window.overrideUserInterfaceStyle = .light
        }
    }
}
