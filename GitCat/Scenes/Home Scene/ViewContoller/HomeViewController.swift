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
    var homeViewModel = HomeViewModel()
    let homeArray = [["Users", "Repositories", "Issues", "Github Web"], ["My Repo"],["Authenticated User Mode"]]
    let imagesArray = [UIImage(named: "UsersIcon"),UIImage(named: "repoIcon"),UIImage(named: "issuesIcon"),UIImage(named: "GitHubIcon")]
    var myRepoModel : RepositoriesForUserModel?
    var searchedWordsArray = [SearchedWord]() 
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let findYourStuffLabel = UILabel()
    let searchGithubLabel = UILabel()
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
    }
    //MARK: - Main Functions
    func initView() {
        homeTableViewConfig()
        searchControllerConfig()
    }
    func initViewModel() {
        fetchMyRepo()
        fetchSearchedWords()
    }
    //MARK: - View Functions
    func tableViewDelegateAndDataSourceConfig (tableViewName : UITableView) {
        tableViewName.delegate = self
        tableViewName.dataSource = self
    }
    func homeTableViewConfig() {
        tableViewDelegateAndDataSourceConfig(tableViewName: homeTableView)
        tableViewNibRegister(tableViewName: homeTableView, nibName: K.homeTableViewCell)
    }
    func searchHistoryTableViewConfig() {
        tableViewDelegateAndDataSourceConfig(tableViewName: searchHistoryTableView)
        tableViewNibRegister(tableViewName: searchHistoryTableView, nibName: K.collectionViewTableViewCellID)
        tableViewNibRegister(tableViewName: searchHistoryTableView, nibName: K.recentSearchTableViewCellID)

    }
    func navigatingSearchTableViewConfig() {
        tableViewDelegateAndDataSourceConfig(tableViewName: navigatingSearchTableView)
        tableViewNibRegister(tableViewName: navigatingSearchTableView, nibName: K.navigatingSearchTableViewCell)
        navigatingSearchTableView.frame = view.bounds
    }
    func searchControllerConfig() {
        searchControllerSetup(searchController: searchController, placeHolder: "Search GitHub")
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
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
                    self.searchHistoryTableView.reloadData()
                }
            } else {
                print(error!)
                self.presentAlert (title: "Error While Fetching Search History Words", message: "")
            }
            
        }
    }
}

