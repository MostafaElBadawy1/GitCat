//
//  UserDetailsViewModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 19/08/2022.
//
import UIKit
class UserDetailsViewModel {
    var bindingData: ((UserModel?,Error?) -> Void) = {_, _ in }
    var user : UserModel? {
        didSet {
            bindingData(user,nil)
        }
    }
    var error: Error!{
        didSet {
            bindingData(nil, error)
        }
    }
    func fetchUserDetails(userName: String) {
        APIManager.shared.fetchSearchedUserProfile(userName: userName)  { result, error in
            switch result {
            case .some(let model):
                DispatchQueue.main.async {
                    self.user = model
                }
            case .none:
                print(error!)
            }
        }
    }
}
//class UserDetailsViewModel {
//    let apiService : ApiService
//    init(apiService: ApiService = NetworkingManager.shared) {
//        self.apiService = apiService
//    }
//    func fetchAllUsers(userName: String) async -> UserModel? {
//        do {
//            let usersList = try await apiService.getUserDetails(userName: userName)
//            return usersList
//        } catch {
//            print(error)
//            return nil
//        }
//    }
//}
