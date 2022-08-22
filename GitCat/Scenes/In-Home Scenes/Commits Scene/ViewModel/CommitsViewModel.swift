//
//  CommitsViewModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 22/08/2022.
//

import UIKit
class CommitsViewModel {
    let apiService : ApiService
    init(apiService: ApiService = NetworkingManager.shared) {
        self.apiService = apiService
    }
    func fetchCommits(ownerName: String, repoName: String, pageNum: Int) async -> [CommitsModel]? {
        do {
            let commitsList = try await apiService.getCommitsForRepo(ownerName: ownerName, repoName: repoName, pageNum: pageNum)
            return commitsList
        } catch {
            print(error)
            return nil
        }
    }
}
