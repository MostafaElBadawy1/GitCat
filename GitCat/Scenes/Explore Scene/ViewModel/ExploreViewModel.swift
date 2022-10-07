//
//  ExploreViewModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 30/08/2022.
//
import Foundation
class ExploreViewModel {
    var pageNumber = 2
    var preFetchIndex = 15
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
    func fetchData(searchWord: String, pageNum: Int) {
        APIManager.shared.searchExploreRepos(searchWord: searchWord, pageName: pageNum) { result,error  in
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

