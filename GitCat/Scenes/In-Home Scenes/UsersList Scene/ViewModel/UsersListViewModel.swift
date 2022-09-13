//
//  UsersListViewModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 21/07/2022.
//
import UIKit
class UsersListViewModel {
    let apiService : ApiService
    init(apiService: ApiService = NetworkingManager.shared) {
        self.apiService = apiService
    }
    func fetchAllUsers(searchKeyword: String, page: Int) async -> [Items]? {
        do {
            let usersList = try await apiService.searchUsers(searchKeyword: searchKeyword, page: page)
            return usersList.items
        } catch {
            print(error)
            return nil
        }
    }
}








//class UsersListViewModel {
//    var users = [Users]() {
//        didSet {
//            bindingData(users,nil)
//        }
//    }
//    var error: Error!{
//        didSet {
//            bindingData(nil, error)
//        }
//    }
//    let apiService : ApiService
//    init(apiService: ApiService = NetworkingManager.shared) {
//        self.apiService = apiService
//    }
//    var bindingData: (([Users]?,Error?) -> Void) = {_, _ in }
//    func fetchAllUsers(id: Int){
//        apiService.getUsersList(id: id) { result in
//            switch result {
//            case .success(let model):
//                //                guard let self = self else {return}
//                DispatchQueue.main.async {
//                    self.users = model
//                }
//            case .failure(let error):
//                //                guard let self = self else {return}
//                print("error")
//                print(error.localizedDescription)
//            }
//        }
//    }
//}
    //    func fetchAllUsers(){
    //        apiService.getUsersList { result in
    //            switch result {
    //            case .success(let model):
    ////                guard let self = self else {return}
    //                DispatchQueue.main.async {
    //                    self.userz = model
    //                    print(self.userz)
    //                }
    //            case .failure(let error):
    ////                guard let self = self else {return}
    //                print("error")
    ////                print(error.localizedDescription)
    //
    //        }
    //        }
    //    }
//}
//        apiService.getUsersList { users, error in
//            switch users {
//            case .success(let model):
//                guard let self = self else {return}
//                DispatchQueue.main.async {
//                    self.users = model
//                    self.tableView.reloadData()
//                    self.spinner.stopAnimating()
//                    self.refreshControl.endRefreshing()
//                }
//            case .failure(let error):
//                guard let self = self else {return}
//                DispatchQueue.main.async {
//                    self.handleError(title: "Error", message: error.localizedDescription)
//                }
//            }
//
// }
//        apiService.getUsersList { users, error in
//            if let users = users{
//                self.userz = [users]
//                print(self.userz!)
//            }else{
//                self.error = error
//            }
//        }
//    }
//}
//class UsersListViewModel {
//
//    let apiService : ApiService
//    init(apiService: ApiService = NetworkingManager.shared) {
//        self.apiService = apiService
//    }
//    func fetchAllUsers(complition: @escaping (UsersListModel?, Error?)->Void){
//    apiService.getUsersList(complition: complition)
//    }
//}
