//
//  ExploreViewModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 30/08/2022.
//
import Foundation
class ExploreViewModel {
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
//class ExploreViewModel {
//    let apiService : ApiService
//    init(apiService: ApiService = NetworkingManager.shared) {
//        self.apiService = apiService
//    }
//    func getExploreRepos(pageNum: Int) async -> [RepositoriesForUserModel]? {
//        do{
//            let reposList = try await apiService.getExploreRepos(pageNum: pageNum)
//            return reposList.items
//        } catch {
//            print(error)
//            return nil
//        }
//    }
//}
