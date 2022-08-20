//
//  RepositoriesForUserViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 20/08/2022.
//

import UIKit

class RepositoriesForUserViewController: UIViewController {
    var repositoriesForUserViewModel = RepositoriesForUserViewModel()
    var reposArray = [RepositoriesForUserModel]()
    @IBOutlet weak var reposTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfig()
        fetchRepos(userName: "mo")
        // Do any additional setup after loading the view.
    }
    //MARK: - View Functions
    func tableViewConfig() {
        reposTableView.delegate = self
        reposTableView.dataSource = self
        reposTableView.prefetchDataSource = self
        reposTableView.register(UINib(nibName: K.RepositoriesTableViewCellID, bundle: .main), forCellReuseIdentifier: K.RepositoriesTableViewCellID)
        reposTableView.frame = view.frame
        //        self.usersListTableView.tableFooterView = createSpinnerFooter()
    }
    //MARK: - Data Function
    func fetchRepos(userName: String) {
        print("LOADING")
        Task.init {
           // try await Task.sleep(nanoseconds: 1_000_000_000)
            if let repos = await repositoriesForUserViewModel.fetchRepos(userName: userName) {
                print(repos)
                self.reposArray = repos
                DispatchQueue.main.async {
                    //self.loadingIndicator.stopAnimating()
                    self.reposTableView.reloadData()
                }
            } else {
                let alert : UIAlertController = UIAlertController(title:"Error While Fetching Repos" , message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

}
extension RepositoriesForUserViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reposArray.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        reposTableView.deselectRow(at: indexPath, animated: true)
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.CommitsViewControllerID) as! CommitsViewController
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reposTableView.dequeueReusableCell(withIdentifier: K.RepositoriesTableViewCellID, for: indexPath)
        return cell
    }
    
    
}
extension RepositoriesForUserViewController: UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
       
    }
    
    
}
