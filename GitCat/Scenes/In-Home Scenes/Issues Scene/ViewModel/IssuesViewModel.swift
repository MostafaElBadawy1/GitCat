//
//  IssuesViewModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 30/08/2022.
//
import UIKit
class IssuesViewModel {
    let apiService : ApiService
    init(apiService: ApiService = NetworkingManager.shared) {
        self.apiService = apiService
    }
    func fetchIssues(searchWord: String, pageNum: Int) async -> [IssuesItems]? {
        do {
            let issues = try await apiService.searchIssues(searchWord: searchWord, pageNum: pageNum)
            return issues.items
        } catch {
            print(error)
            return nil
        }
    }
}
