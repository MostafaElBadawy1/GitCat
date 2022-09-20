//
//  HomeViewModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 31/08/2022.
//
import UIKit
//class HomeViewModel {
//    let apiService : ApiService
//    init(apiService: ApiService = NetworkingManager.shared) {
//        self.apiService = apiService
//    }
//    func fetchMyRepo() async -> MyRepo? {
//        do {
//            let myRepo = try await apiService.getMyRepo()
//            return myRepo
//        } catch {
//            print(error)
//            return nil
//        }
//    }
//}
class HomeViewModel {
    var bindingData: ((RepositoriesForUserModel?,Error?) -> Void) = {_, _ in }
    var repo : RepositoriesForUserModel? {
        didSet {
            bindingData(repo,nil)
        }
    }
    var error: Error!{
        didSet {
            bindingData(nil, error)
        }
    }
    func fetchMyRepo() {
        APIManager.shared.fetchMyRepo() { result, error in
            switch result {
            case .some(let model):
                DispatchQueue.main.async {
                    self.repo = model
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
