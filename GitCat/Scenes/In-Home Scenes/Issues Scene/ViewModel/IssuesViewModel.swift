//
//  IssuesViewModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 30/08/2022.
//
import Foundation
class IssuesViewModel {
    var pageNum = 1
    var preFetchIndex = 15
    var bindingData: (([IssuesItems]?,Error?) -> Void) = {_, _ in }
    var issues : [IssuesItems]? {
        didSet {
            bindingData(issues,nil)
        }
    }
    var error: Error!{
        didSet {
            bindingData(nil, error)
        }
    }
    func searchIssues(searchWord: String, pageNum: Int) {
        APIManager.shared.searchIssues(searchWord: searchWord, pageNum: pageNum) { result, error in
            switch result {
            case .some(let model):
                DispatchQueue.main.async {
                    self.issues = model
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
