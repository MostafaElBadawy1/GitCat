//
//  UserDetailsViewModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 19/08/2022.
//

import UIKit
class UserDetailsViewModel {
    let apiService : ApiService
    init(apiService: ApiService = NetworkingManager.shared) {
        self.apiService = apiService
    }
    func fetchAllUsers(userName: String) async -> UserModel? {
        do {
            let usersList = try await apiService.getUserDetails(userName: userName)
            return usersList
        } catch {
            print(error)
            return nil
        }
    }
}
