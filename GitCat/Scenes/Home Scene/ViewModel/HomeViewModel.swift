//
//  HomeViewModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 31/08/2022.
//
import UIKit
class HomeViewModel {
    let apiService : ApiService
    init(apiService: ApiService = NetworkingManager.shared) {
        self.apiService = apiService
    }
    func fetchMyRepo() async -> MyRepo? {
        do {
            let myRepo = try await apiService.getMyRepo()
            return myRepo
        } catch {
            print(error)
            return nil
        }
    }
}
