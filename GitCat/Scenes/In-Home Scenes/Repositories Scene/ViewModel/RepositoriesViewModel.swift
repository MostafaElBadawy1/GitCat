//
//  RepositoriesViewModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 20/08/2022.
//
import UIKit
class RepositoriesViewModel {
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
    func searchRepos(userName: String, pageNum: Int) async -> [RepoItems]? {
        do{
            let reposList = try await apiService.searchRepos(userName: userName, pageNum: pageNum)
            return reposList.items
        } catch {
            print(error)
            return nil
        }
    }
    func fetchStarredRepos(userName: String, pageNum: Int) async -> [StarredReposModel]? {
        do {
            let starredReposList = try await apiService.getStarredRepos(userName: userName, pageNum: pageNum)
            return starredReposList
        } catch {
            print(error)
            return nil
        }
    }

}

