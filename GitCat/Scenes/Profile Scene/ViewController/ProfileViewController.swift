//
//  ProfileViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 09/08/2022.
//
import UIKit
import Kingfisher
import AuthenticationServices
class ProfileViewController: UIViewController {
    var profileViewModel = ProfileViewModel()
    let userDetailsArray = ["Repositories","Starred","Organization"]
    let imagesArray = [UIImage(named: "repoIcon"),UIImage(named: "Star"),UIImage(named: "Organization")]
    var user : UserModel?
    let loadingIndicator = UIActivityIndicatorView()
    let loginButton = UIButton()
    let label = UILabel()
    var webAuthenticationSession: ASWebAuthenticationSession?
    var isLoggedIn: Bool {
        if TokenManager.shared.fetchAccessToken() != nil {
            return true
        }
        return false
    }
    @IBOutlet weak var shareLinkButtonIcon: UIBarButtonItem!
    @IBOutlet weak var profileTableView: UITableView!
    @IBAction func settingButton(_ sender: UIBarButtonItem) {
        let settingsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.SettingsViewControllerID) as! SettingsViewController
        settingsVC.passedDataFromProfileVC = user
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
    @IBAction func shareLink(_ sender: UIBarButtonItem) {
        presentShareSheet()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if isLoggedIn {
            tableViewConfig()
            fetchUserData ()
            label.isHidden = true
            loginButton.isHidden = true
        } else {
            LabelConfig()
            loginButtonConfig()
            if #available(iOS 16.0, *) {
                shareLinkButtonIcon.isHidden = true
            } else {
            }
        }
    }
    func tableViewConfig() {
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.register(UINib(nibName: K.UserDetailsTableViewCellID, bundle: .main), forCellReuseIdentifier: K.UserDetailsTableViewCellID)
        profileTableView.register(UINib(nibName: K.homeTableViewCell, bundle: .main), forCellReuseIdentifier: K.homeTableViewCell)
        profileTableView.frame = view.frame
    }
    func LabelConfig(){
        label.text = "Not Logged In."
        label.font = UIFont.boldSystemFont(ofSize: 20)
        //label.translatesAutoresizingMaskIntoConstraints = false
        label.frame =  CGRect(x: 140, y: 400, width: 300, height: 50)
        self.view.addSubview(label)
    }
    private func presentShareSheet() {
        let image = UIImageView()
        guard let url = URL(string: (user?.html_url)!) else {
            return
        }
        image.kf.setImage(with: URL(string: (user?.avatar_url!)!),placeholder: UIImage(named: "UsersIcon"))
        let shareSheetVC = UIActivityViewController(activityItems: [image, url], applicationActivities: nil)
        present(shareSheetVC, animated: true)
    }
    func presentAlert(title: String, message: String) {
        let alert : UIAlertController = UIAlertController(title:title , message: title, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func loginButtonConfig() {
        loginButton.frame = CGRect(x: 155, y: 450, width: 100, height: 40)
        loginButton.backgroundColor = .systemFill
        loginButton.setTitle("Login", for: .normal)
        //button.tintColor = .darkText
        // button.titleLabel?.font = .boldSystemFont(ofSize: 13)
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderWidth = 0.25
        loginButton.layer.borderColor = UIColor.white.cgColor
        loginButton.clipsToBounds = true
        loginButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(loginButton)
    }
    @objc func buttonAction(sender: UIButton!) {
        getGitHubIdentity()
    }
    func fetchUserData () {
        self.loadingIndicator.startAnimating()
        self.profileTableView.isHidden = true
        profileViewModel.fetchUserDetails()
        profileViewModel.bindingData = { userData, error in
            if let user = userData {
                self.user = user
                DispatchQueue.main.async {
                    self.profileTableView.reloadData()
                    self.loadingIndicator.stopAnimating()
                    self.profileTableView.isHidden = false
                }
            }
            if error != nil {
                self.presentAlert(title: "Error while fetching your data", message: "")
                print(error!)
            }
        }
    }
    func getGitHubIdentity() {
        var authorizeURLComponents = URLComponents(string: K.GitHubConstants.authorizeURL)
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
                        presentAlert(title: "Error While Fetching Access Token", message: "")
                    }
                    viewDidLoad()
                }
            }
        webAuthenticationSession?.presentationContextProvider = self
        webAuthenticationSession?.start()
    }
}
// MARK: - ASWebAuthenticationPresentationContextProviding
extension ProfileViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return view.window ?? ASPresentationAnchor()
    }
}

