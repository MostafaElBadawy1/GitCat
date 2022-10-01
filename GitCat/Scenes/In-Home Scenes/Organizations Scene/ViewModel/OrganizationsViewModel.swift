//
//  OrganizationsViewModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 23/08/2022.
//
import Foundation
class OrganizationsViewModel {
    var bindingData: (([OrganizationModel]?,Error?) -> Void) = {_, _ in }
    var orgs = [OrganizationModel]() {
        didSet {
            bindingData(orgs,nil)
        }
    }
    var error: Error!{
        didSet {
            bindingData(nil, error)
        }
    }
    func fetchOrgs(userName: String) {
        APIManager.shared.fetchUsersOrgs(userName: userName) { result,error  in
            switch result {
            case .some(let model):
                DispatchQueue.main.async {
                    self.orgs = model
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
