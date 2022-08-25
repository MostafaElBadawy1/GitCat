//
//  OrganizationsViewModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 23/08/2022.
//
import UIKit
class OrganizationsViewModel {
    let apiService: ApiService
    init(apiService: ApiService = NetworkingManager.shared) {
        self.apiService = apiService
    }
    func fetchUserOrg(userName: String) async -> [OrganizationModel]? {
        do {
            let orgsList = try await apiService.getUserOrgs(userName: userName)
            return orgsList
        } catch {
            print(error)
            return nil
        }
    }
}
