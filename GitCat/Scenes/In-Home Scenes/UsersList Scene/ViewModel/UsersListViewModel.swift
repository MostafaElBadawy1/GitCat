//
//  UsersListViewModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 21/07/2022.
//
import UIKit
class UsersListViewModel {
    var bindingData: (([UserModel]?,Error?) -> Void) = {_, _ in }
    var users = [UserModel]() {
        didSet {
            bindingData(users,nil)
        }
    }
    var error: Error!{
        didSet {
            bindingData(nil, error)
        }
    }
    func fetchSearchedUsers(searchWord: String, PageNum: Int) {
        APIManager.shared.searchUsers(searchKeyword: searchWord, pageNum: PageNum) { result, error in
            switch result {
            case .some(let model):
                DispatchQueue.main.async {
                    self.users = model
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

