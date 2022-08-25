//
//  SearchHistoryViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 22/08/2022.
//
import UIKit
class SearchHistoryViewController: UIViewController {
    //MARK: - Props
    private var searchHistoryTableView: UITableView!
    var recentSearchResultArray:[String] = ["d","s","sdsd"]
    let firstlabel = UILabel()
    let secondlabel = UILabel()
    let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
    var recentVisitedUsersHeader: RecentVisitedUsersHeader!
    //MARK: - IBOutlets

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        InitViewModel()
        if recentSearchResultArray.isEmpty{
            searchHistoryTableView.isHidden = true
        }
        //searchHistoryTableView.isHidden = true
    }
    //MARK: - Main Functions
    func initView(){
        labelsConfig()
        tableViewConfig()
        headerConfig()
        //view.backgroundColor = .blue
        //tableViewConfig()
    }
    func InitViewModel(){
        
    }
    //MARK: - View Functions
    func tableViewConfig() {
       // searchHistoryTableView.frame = view.bounds
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        searchHistoryTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        searchHistoryTableView.register(UINib(nibName: K.RecentSearchTableViewCellID, bundle: .main), forCellReuseIdentifier: K.RecentSearchTableViewCellID)
        searchHistoryTableView.dataSource = self
        searchHistoryTableView.delegate = self
        self.view.addSubview(searchHistoryTableView)
        //searchHistoryTableView.isHidden = true
    }
    func labelsConfig(){
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
    func headerConfig(){
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 80)
        recentVisitedUsersHeader = RecentVisitedUsersHeader(frame: frame)
        searchHistoryTableView.tableHeaderView = recentVisitedUsersHeader
        searchHistoryTableView.tableHeaderView?.backgroundColor = .systemGray6
    }
}
extension SearchHistoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentSearchResultArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchHistoryTableView.dequeueReusableCell(withIdentifier: K.RecentSearchTableViewCellID) as! RecentSearchTableViewCell
        cell.recentSearchLabel.text = recentSearchResultArray[indexPath.row]
        return cell
    }
}
