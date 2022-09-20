//
//  IssuesViewModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 30/08/2022.
//
import UIKit
class IssuesViewModel {
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
//class IssuesViewModel {
//    let apiService : ApiService
//    init(apiService: ApiService = NetworkingManager.shared) {
//        self.apiService = apiService
//    }
//    func fetchIssues(searchWord: String, pageNum: Int) async -> [IssuesItems]? {
//        do {
//            let issues = try await apiService.searchIssues(searchWord: searchWord, pageNum: pageNum)
//            return issues.items
//        } catch {
//            print(error)
//            return nil
//        }
//    }
//}
