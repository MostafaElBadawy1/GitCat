//
//  HomeViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 04/08/2022.
//
import UIKit
import Kingfisher
class HomeViewController: UIViewController {
    //MARK: - Props
    let searchController = UISearchController()
    var searchHistoryVC = SearchHistoryViewController()
    var homeViewModel = HomeViewModel()
    let homeArray = [["Users", "Repositories", "Issues", "Github Web"], ["My Repo"],["Authenticated User Mode"]]
    let imagesArray = [UIImage(named: "UsersIcon"),UIImage(named: "repoIcon"),UIImage(named: "issuesIcon"),UIImage(named: "GitHubIcon")]
    var myRepoModel : RepositoriesForUserModel?
    var visitedUserArray = [VisitedUser]()
    var searchedWordsArray = [SearchedWord]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let firstlabel = UILabel()
    let secondlabel = UILabel()
    var isLoggedIn: Bool {
        if TokenManager.shared.fetchAccessToken() != nil {
            return true
        }
        return false
    }
    var query: String? {
           didSet {
               navigatingSearchTableView.reloadData()
           }
       }
    //MARK: - IBOutlets
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var searchHistoryTableView: UITableView!
    @IBOutlet weak var navigatingSearchTableView: UITableView!
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
//        homeTableView.isHidden = true
//        searchHistoryTableView.isHidden = true
//        navigatingSearchTableView.isHidden = false
    }
    //MARK: - Main Functions
    func initView() {
        tableViewConfig()
        //searchHistoryTableViewConfig()
        //navigatingSearchTableViewConfig()
        searchControllerConfig()
//        navigatingSearchTableView.isHidden = true
//        searchHistoryTableView.isHidden = true
    }
    func initViewModel() {
        fetchMyRepo()
        fetchSearchedWords()
        fetchVisitedUsers()
    }
    //MARK: - View Functions
    func tableViewConfig() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.register(UINib(nibName: K.homeTableViewCell, bundle: .main), forCellReuseIdentifier: K.homeTableViewCell)
       // self.homeTableView.isHidden = true
    }
    func searchHistoryTableViewConfig() {
        searchHistoryTableView.delegate = self
        searchHistoryTableView.dataSource = self
        searchHistoryTableView.register(UINib(nibName: K.CollectionViewTableViewCellID, bundle: .main), forCellReuseIdentifier:  K.CollectionViewTableViewCellID)
        searchHistoryTableView.register(UINib(nibName: K.RecentSearchTableViewCellID, bundle: .main), forCellReuseIdentifier: K.RecentSearchTableViewCellID)
        searchHistoryTableView.frame = view.bounds
       // searchHistoryTableView.isHidden = true
    }
    func navigatingSearchTableViewConfig() {
        navigatingSearchTableView.delegate = self
        navigatingSearchTableView.dataSource = self
        navigatingSearchTableView.register(UINib(nibName: K.navigatingSearchTableViewCell, bundle: .main), forCellReuseIdentifier:  K.navigatingSearchTableViewCell)
        navigatingSearchTableView.frame = view.bounds
       // navigatingSearchTableView.isHidden = false
    }
    func searchControllerConfig() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        //searchController.delegate = self
        // Monitor when the search button is tapped, and start/end editing.
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search GitHub"
    }
    func presentAlert (title: String, message: String) {
        let alert : UIAlertController = UIAlertController(title:title , message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func emptySearchVClabelsConfig(){
        firstlabel.frame = CGRect(x: 0, y: 0, width: 200, height: 21)
        firstlabel.center = CGPoint(x: 200, y: 420)
        firstlabel.textAlignment = .center
        firstlabel.text = "Find Your stuff."
        firstlabel.font = .boldSystemFont(ofSize: 19)
        self.view.addSubview(firstlabel)
        secondlabel.frame =  CGRect(x: 0, y: 0, width: 400, height: 60)
        secondlabel.center = CGPoint(x: 205, y: 475)
        secondlabel.textAlignment = .center
        secondlabel.text = "Search all of GitHub for People, Repositories, Organizations, Issues, and Pull Requests"
        secondlabel.numberOfLines = 0
        secondlabel.textColor = .gray
        self.view.addSubview(secondlabel)
    }
    //MARK: - Data Functions
    func fetchMyRepo() {
        homeViewModel.fetchMyRepo()
        homeViewModel.bindingData = { repo, error in
            if let myRepo = repo {
                self.myRepoModel = myRepo
                DispatchQueue.main.async {
                    self.homeTableView.reloadData()
                   // self.homeTableView.isHidden = false
                }
            } else {
                print(error!)
                self.presentAlert (title: "Error While Fetching Your Repo Name And Image", message: "")
            }
        }
    }
    func fetchSearchedWords() {
        CoreDataManger.shared.fetch(entityName: SearchedWord.self) { (words, error) in
            if let words = words {
                self.searchedWordsArray = words
                DispatchQueue.main.async {
                    //self.searchHistoryTableView.reloadData()
                }
            } else {
                print(error!)
                self.presentAlert (title: "Error While Fetching Search History Words", message: "")
            }
            
        }
    }
    func fetchVisitedUsers() {
        CoreDataManger.shared.fetch(entityName: VisitedUser.self) { (users, error) in
            if let users = users {
                self.visitedUserArray = users
                DispatchQueue.main.async {
                 //   self.searchHistoryTableView.reloadData()
                }
            }  else {
                print(error!)
                self.presentAlert (title: "Error While Fetching Search History Users", message: "")
            }
        }
    }
}

