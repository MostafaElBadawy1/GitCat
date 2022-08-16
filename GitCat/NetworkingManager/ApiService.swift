//
//  ApiService.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 20/07/2022.
//

import Foundation
protocol ApiService {
    func getUsersList(searchKeyword: String, page: Int) async throws -> SearchUsersModel
    //    func getUsersList<T: Codable>(model: T.Type) async throws -> T
//    func getUsersList (id:Int, completionHandler: @escaping (Result<[SearchUsersModel], Error>) -> Void)
//    func getUsersList(complition: @escaping (UsersListModel?, Error?)->Void)
}
