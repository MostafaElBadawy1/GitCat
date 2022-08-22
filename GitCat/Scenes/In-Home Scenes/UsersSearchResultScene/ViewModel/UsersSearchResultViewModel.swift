//
//  UsersSearchResultViewModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 16/08/2022.
//

import UIKit
class UsersSearchResultViewModel {
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
