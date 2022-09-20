//
//  ProfileViewModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 14/09/2022.
//
import Foundation
class ProfileViewModel {
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
    func fetchUserDetails() {
        APIManager.shared.fetchUserProfile { result, error in
            switch result {
            case .some(let model):
                DispatchQueue.main.async {
                    self.user = model
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
