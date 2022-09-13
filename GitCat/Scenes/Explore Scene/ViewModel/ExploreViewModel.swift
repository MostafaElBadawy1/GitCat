//
//  ExploreViewModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 30/08/2022.
//
import UIKit
class ExploreViewModel {
    let apiService : ApiService
    init(apiService: ApiService = NetworkingManager.shared) {
        self.apiService = apiService
    }
    func getExploreRepos(pageNum: Int) async -> [RepositoriesForUserModel]? {
        do{
            let reposList = try await apiService.getExploreRepos(pageNum: pageNum)
            return reposList.items
        } catch {
            print(error)
            return nil
        }
    }
}
