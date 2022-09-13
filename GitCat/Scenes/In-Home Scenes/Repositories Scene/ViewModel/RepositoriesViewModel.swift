//
//  RepositoriesViewModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 20/08/2022.
//
import UIKit
//class RepositoriesViewModel {
//   // var repositories: [RepositoriesForUserModel] = []
//    let apiService : ApiService
//    init(apiService: ApiService = NetworkingManager.shared) {
//        self.apiService = apiService
//    }
//    func fetchRepos(userName: String, pageNum: Int) async -> [RepositoriesForUserModel]? {
//        do {
//            let reposList = try await apiService.getReposForUser(userName: userName, pageNum: pageNum)
//            return reposList
//        } catch {
//            print(error)
//            return nil
//        }
//    }
//    func searchRepos(searchKeyword: String, pageNum: Int) async -> [RepositoriesForUserModel]? {
//        do{
//            let reposList = try await apiService.searchRepos(searchKeyword: searchKeyword, pageNum: pageNum)
//            return reposList.items
//        } catch {
//            print(error)
//            return nil
//        }
//    }
//}

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
        
        func fetchData(searchWord: String) {
            APIManager.shared.searchRepositories(for: searchWord) { result,error  in
                switch result {
                case .some(let model):
                    print(model)
                    print(self.repos)
                                   //guard let self = self else {return}
                    DispatchQueue.main.async {
                        self.repos = model
                    }
                case .none:
                                   // guard let self = self else {return}
                    print(error!)
                }
            }
        }
}
//class RepositoriesViewModel {
////    func fetchData(searchWord: String, completion: @escaping ([RepositoriesForUserModel]) -> Void) {
////        Networking.shared.searchRepositories(for: searchWord) { repos in
////            self.repositories = repos
////
////            //print(repos)
////        }
////        //return repositories
////    }
//    var bindingData: (([RepositoriesForUserModel]?,Error?) -> Void) = {_, _ in }
//        var repos = [RepositoriesForUserModel]() {
//            didSet {
//                bindingData(repos,nil)
//            }
//        }
//        var error: Error!{
//            didSet {
//                bindingData(nil, error)
//            }
//        }
////        let apiService : ApiService
////        init(apiService: ApiService = NetworkingManager.shared) {
////            self.apiService = apiService
////        }
//
//        func fetchData(searchWord: String) {
//            APIManager.shared.searchRepositories(for: searchWord) { result,error  in
//                switch result {
//                case .some(let model):
//                    //                guard let self = self else {return}
//                    DispatchQueue.main.async {
//                        self.repos = model
//                    }
//                case .none:
//                    //                guard let self = self else {return}
//                    print(error!)
//                }
//            }
////            apiService.getUsersList(id: id) { result in
////                switch result {
////                case .success(let model):
////                    //                guard let self = self else {return}
////                    DispatchQueue.main.async {
////                        self.users = model
////                    }
////                case .failure(let error):
////                    //                guard let self = self else {return}
////                    print(error)
////                }
////            }
//        }
//}
