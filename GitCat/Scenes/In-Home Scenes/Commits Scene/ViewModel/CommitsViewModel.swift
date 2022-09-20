//
//  CommitsViewModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 22/08/2022.
//
import UIKit
class CommitsViewModel {
    var bindingData: (([CommitsModel]?,Error?) -> Void) = {_, _ in }
    var commits = [CommitsModel]() {
        didSet {
            bindingData(commits,nil)
        }
    }
    var error: Error!{
        didSet {
            bindingData(nil, error)
        }
    }
    func fetchCommits(ownerName: String, repoName: String, pageNum: Int) {
        APIManager.shared.fetchCommits(ownerName: ownerName, repoName: repoName, pageNum: pageNum) { result,error  in
            switch result {
            case .some(let model):
                DispatchQueue.main.async {
                    self.commits = model
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
