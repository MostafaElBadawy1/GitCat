//
//  RepositoriesViewModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 20/08/2022.
//
import Foundation
class RepositoriesViewModel {
    var bindingData: (([RepositoriesForUserModel]?,Error?) -> Void) = {_, _ in }
    var repos = [RepositoriesForUserModel]() {
        didSet {
            bindingData(repos,nil)
        }
    }
    var error: Error!{
        didSet {
            bindingData(nil, error)
        }
    }
    
    func searchRepos(searchWord: String, pageNum: Int) {
        APIManager.shared.searchRepositories(for: searchWord, pageNum: pageNum) { result,error  in
            switch result {
            case .some(let model):
                DispatchQueue.main.async {
                    self.repos = model
                }
            case .none:
                switch error {
                case .some(let error):
                    self.error = error
                case .none :
                    return
                }
            }
        }
    }
    func fetchUserRepositories(repoOwner: String, pageNum: Int) {
        APIManager.shared.fetchUserRepositories(repoOwner: repoOwner, pageNum: pageNum) { result, error in
            switch result {
            case .some(let model):
                DispatchQueue.main.async {
                    self.repos = model
                }
            case .none:
                switch error {
                case .some(let error):
                    self.error = error
                case .none :
                    return
                }
            }
        }
    }
    func fetchMyRepositories() {
        APIManager.shared.fetchMyRepositories { result, error in
            switch result {
            case .some(let model):
                DispatchQueue.main.async {
                    self.repos = model
                }
            case .none:
                switch error {
                case .some(let error):
                    self.error = error
                case .none :
                    return
                }
            }
        }
    }
    func fetchUserStarredRepositories(userName: String) {
        APIManager.shared.fetchStarredRepositories(userName: userName) { result, error in
            switch result {
            case .some(let model):
                DispatchQueue.main.async {
                    self.repos = model
                }
            case .none:
                switch error {
                case .some(let error):
                    self.error = error
                case .none :
                    return
                }
            }
        }
    }

}

