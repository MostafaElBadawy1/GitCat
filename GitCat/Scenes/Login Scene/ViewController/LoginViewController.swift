//
//  LoginViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 09/09/2022.
//
import UIKit
import AuthenticationServices
class LoginViewController: UIViewController {
    var webAuthenticationSession: ASWebAuthenticationSession?
    @IBOutlet weak var appLogo: UIImageView!
    @IBAction func signInButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Sign in with GitHub", style: .default, handler: { _ in
            self.getGitHubIdentity()
        }))
        alert.addAction(UIAlertAction(title:"Guest Mode", style: .default, handler: { _ in
            let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.tabBarID) as! UITabBarController
            tabBarVC.modalPresentationStyle = .fullScreen
            self.present(tabBarVC, animated: true, completion: nil)
        print("Guest Mode")
        }))
        alert.addAction(UIAlertAction(title:"Cancel", style: .cancel, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        appLogo.image = UIImage(named: "GitHubLoginLogo")
    }
    func getGitHubIdentity() {
        var authorizeURLComponents = URLComponents(string: K.GitHubConstants.authorizeURL)
        print(K.GitHubConstants.scope)
      authorizeURLComponents?.queryItems = [
        URLQueryItem(name: "client_id", value: K.GitHubConstants.clientID),
        URLQueryItem(name: "scope", value: K.GitHubConstants.scope)
      ]
      guard let authorizeURL = authorizeURLComponents?.url else {
        return
      }
      webAuthenticationSession = ASWebAuthenticationSession.init(
        url: authorizeURL,
        callbackURLScheme: K.GitHubConstants.redirectURI) { (callBack: URL?, error: Error?) in
        guard
          error == nil,
          let successURL = callBack
        else {
          return
        }
        guard let accessCode = URLComponents(string: (successURL.absoluteString))?
          .queryItems?.first(where: { $0.name == "code" }) else {
          return
        }
        guard let value = accessCode.value else {
          return
        }
            APIManager.shared.fetchAccessToken(accessCode: value) { [self] isSuccess in
              if !isSuccess {
                print("Error fetching access token")
              }
                let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.tabBarID) as! UITabBarController
                tabBarVC.modalPresentationStyle = .fullScreen
                self.present(tabBarVC, animated: true, completion: nil)
            }
      }
      webAuthenticationSession?.presentationContextProvider = self
      webAuthenticationSession?.start()
    }
}
// MARK: - ASWebAuthenticationPresentationContextProviding
extension LoginViewController: ASWebAuthenticationPresentationContextProviding {
  func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
    return view.window ?? ASPresentationAnchor()
  }
}
