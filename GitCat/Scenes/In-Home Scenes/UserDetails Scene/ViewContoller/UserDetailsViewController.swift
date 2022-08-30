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
    var usersModel = [User]()
    //var workoutSet = Set<usersModel>()
    //var userSet : Set = Set<usersModel>: usersModel

    //MARK: - IBOutlets
    @IBOutlet weak var userDetailsTableView: UITableView!
    //MARK: - @IBAction
    @IBAction func safariViewButton(_ sender: UIBarButtonItem) {
        if let userURL = URL(string:"\(self.user!.html_url!)" ){
            UIApplication.shared.open(userURL)
            print(userURL)
        }
    }
    @IBAction func shareUserButton(_ sender: UIBarButtonItem) {
        presentShareSheet()
    }
//    @IBAction func tryAgainButton(_ sender: UIButton) {
//        fetchUser()
//        self.userDetailsTableView.reloadData()
//        print("tryAgzin")
//    }
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
        userDetailsTableView.register(UINib(nibName: K.homeTableViewCell, bundle: .main), forCellReuseIdentifier: K.homeTableViewCell)
        userDetailsTableView.register((UINib(nibName: K.UserDetailsTableViewCellID, bundle: .main)), forCellReuseIdentifier: K.UserDetailsTableViewCellID)
        userDetailsTableView.frame = view.frame
        navigationItem.largeTitleDisplayMode = .never
        //userDetailsTableView.tintColor = .systemGray6
        //userDetailsTableView.isHidden = true
        loadingIndicator.startAnimating()
    }
    func tryAgainButtonConfig() {
        tryAgainButton.frame = CGRect(x: 165, y: 400, width: 100, height: 40)
        tryAgainButton.backgroundColor = .systemFill
        tryAgainButton.setTitle("Try Again", for: .normal)
        //button.tintColor = .darkText
       // button.titleLabel?.font = .boldSystemFont(ofSize: 13)
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
            let alert : UIAlertController = UIAlertController(title:"You Are Disconnected" , message: "Please Check Your Connection!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
        //let image =.kf.setImage(with: URL(string: passeedDataFromUserListVC.avatar_url),placeholder: UIImage(named: "UsersIcon"))
        guard  let url = URL(string: user!.html_url!) else {
            return
        }
        let shareSheetVC = UIActivityViewController(activityItems: [ url], applicationActivities: nil)
        present(shareSheetVC, animated: true)
    }
    //MARK: - Data Function
    func fetchUser() {
        Task.init {
            if let user = await userDetailsViewModel.fetchAllUsers(userName: passeedDataFromUserListVC!) {
                self.user = user
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    self.userDetailsTableView.reloadData()
                    self.userDetailsTableView.isHidden = false
                    self.tryAgainButton.isHidden = true
                }
//                if user.login == nil{
//                    userDetailsTableView.isHidden = true
//                    tryAgainButtonConfig()
//                }
            } else {
                let alert : UIAlertController = UIAlertController(title:"Error While Fetching User" , message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
   
}
//        userDetailsTableView.frame = view.frame
// let header = UIView(frame: CGRect(x: 120, y: 100, width: view.frame.size.width, height: 150))
// userDetailsTableView.tableHeaderView = header
// header.backgroundColor = .green
