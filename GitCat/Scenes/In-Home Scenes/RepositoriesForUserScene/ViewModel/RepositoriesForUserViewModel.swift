//
//  RepositoriesForUserViewModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 20/08/2022.
//
import UIKit
class RepositoriesForUserViewModel {
    let apiService : ApiService
    init(apiService: ApiService = NetworkingManager.shared) {
        self.apiService = apiService
    }
    func fetchRepos(userName: String, pageNum: Int) async -> [RepositoriesForUserModel]? {
        do {
            let reposList = try await apiService.getReposForUser(userName: userName, pageNum: pageNum)
            return reposList
        } catch {
            print(error)
            return nil
        }
    }
}
