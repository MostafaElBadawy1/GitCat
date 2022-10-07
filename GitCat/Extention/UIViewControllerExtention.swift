//
//  UIViewControllerExtention.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 07/10/2022.
//
import UIKit
extension UIViewController {
    func tableViewNibRegister(tableViewName : UITableView, nibName : String){
        tableViewName.register(UINib(nibName: nibName , bundle: .main), forCellReuseIdentifier: nibName)
    }
    func presentAlert (title: String, message: String) {
        let alert : UIAlertController = UIAlertController(title:title , message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func searchControllerSetup(searchController: UISearchController, placeHolder: String) {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = placeHolder
    }
    func emptySearchVClabelsConfig(firstLabel: UILabel, secondLabel: UILabel){
        firstLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 21)
        firstLabel.center = CGPoint(x: 200, y: 420)
        firstLabel.textAlignment = .center
        firstLabel.text = "Find Your stuff."
        firstLabel.font = .boldSystemFont(ofSize: 19)
        self.view.addSubview(firstLabel)
        secondLabel.frame =  CGRect(x: 0, y: 0, width: 400, height: 60)
        secondLabel.center = CGPoint(x: 205, y: 475)
        secondLabel.textAlignment = .center
        secondLabel.text = "Search all of GitHub for People, Repositories, Organizations, Issues, and Pull Requests"
        secondLabel.numberOfLines = 0
        secondLabel.textColor = .gray
        self.view.addSubview(secondLabel)
    }
    func networkReachability(loadingIndicator: UIActivityIndicatorView){
        loadingIndicator.style = .medium
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
        if NetworkMonitor.shared.isConnected {
            loadingIndicator.stopAnimating()
        } else {
            presentAlert (title: "You Are Disconnected", message: "Please Check Your Connection!")
            loadingIndicator.startAnimating()
        }
    }
    func createSpinnerFooter(loadingIndicator: UIActivityIndicatorView)-> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        footerView.addSubview(loadingIndicator)
        loadingIndicator.center = footerView.center
        loadingIndicator.startAnimating()
        return footerView
    }
}
