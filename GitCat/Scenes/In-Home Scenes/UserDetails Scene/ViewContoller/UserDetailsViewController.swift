//
//  UserDetailsViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 08/08/2022.
//
import UIKit
import Kingfisher
class UserDetailsViewController: UIViewController {
    //MARK: - Props
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var passeedDataFromUserListVC : String?
    var user : UserModel?
    var userDetailsViewModel = UserDetailsViewModel()
    let loadingIndicator = UIActivityIndicatorView()
    let userDetailsArray = ["Repositories","Starred","Organization"]
    let imagesArray = [UIImage(named: "repoIcon"),UIImage(named: "Star"),UIImage(named: "Organization")]
    let tryAgainButton = UIButton()
    var isSaved = false
    //MARK: - IBOutlets
    @IBOutlet weak var userDetailsTableView: UITableView!
    //MARK: - @IBAction
    @IBAction func safariViewButton(_ sender: UIBarButtonItem) {
        if let userURL = URL(string:"\(self.user!.html_url!)" ){
            UIApplication.shared.open(userURL)
        }
    }
    @IBAction func shareUserButton(_ sender: UIBarButtonItem) {
        presentShareSheet()
    }
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfig()
        fetchUser()
        networkReachability()
        refreshPage()
    }
    //MARK: - Main Functions
    func initView(){
        tableViewConfig()
        fetchUser()
        networkReachability()
        refreshPage()
    }
    func InitViewModel(){
        fetchUser()
    }
    //MARK: - View Functions
    func tableViewConfig() {
        userDetailsTableView.delegate = self
        userDetailsTableView.dataSource = self
        tableViewNibRegister(tableViewName: userDetailsTableView, nibName: K.homeTableViewCell)
        tableViewNibRegister(tableViewName: userDetailsTableView, nibName: K.userDetailsTableViewCellID)
        userDetailsTableView.frame = view.frame
        navigationItem.largeTitleDisplayMode = .never
        userDetailsTableView.isHidden = true
        loadingIndicator.startAnimating()
    }
    func tryAgainButtonConfig() {
        tryAgainButton.frame = CGRect(x: 165, y: 400, width: 100, height: 40)
        tryAgainButton.backgroundColor = .systemFill
        tryAgainButton.setTitle("Try Again", for: .normal)
        tryAgainButton.layer.cornerRadius = 5
        tryAgainButton.layer.borderWidth = 0.25
        tryAgainButton.layer.borderColor = UIColor.white.cgColor
        tryAgainButton.clipsToBounds = true
        tryAgainButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(tryAgainButton)
    }
    @objc func buttonAction(sender: UIButton!) {
        fetchUser()
        userDetailsTableView.reloadData()
    }
    func networkReachability(){
        loadingIndicator.style = .medium
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
        if NetworkMonitor.shared.isConnected {
            loadingIndicator.stopAnimating()
            userDetailsTableView.isHidden = false
        } else {
            userDetailsTableView.isHidden = true
            presentAlert(title: "You Are Disconnected", message: "Please Check Your Connection!")
            loadingIndicator.startAnimating()
            userDetailsTableView.isHidden = true
            tryAgainButtonConfig()
        }
    }
    func refreshPage(){
        self.userDetailsTableView.refreshControl = UIRefreshControl()
        self.userDetailsTableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    @objc private func refreshData() {
        fetchUser()
        self.userDetailsTableView.reloadData()
    }
    private func presentShareSheet() {
        guard  let url = URL(string: user!.html_url!) else {
            return
        }
        let shareSheetVC = UIActivityViewController(activityItems: [ url], applicationActivities: nil)
        present(shareSheetVC, animated: true)
    }
    //MARK: - Data Function
    func fetchUser() {
        self.loadingIndicator.startAnimating()
        self.userDetailsTableView.isHidden = true
        
        if let passedUsername = passeedDataFromUserListVC {
            userDetailsViewModel.fetchUserDetails(userName: passedUsername)
        }
        userDetailsViewModel.bindingData = { userData, error in
            if let user = userData {
                self.user = user
                DispatchQueue.main.async {
                    self.userDetailsTableView.reloadData()
                    self.loadingIndicator.stopAnimating()
                    self.userDetailsTableView.isHidden = false
                }
            }
            if let error = error {
                self.presentAlert(title: "Error While Fetching User's Details", message: "")
                print(error)
            }
        }
    }
}
