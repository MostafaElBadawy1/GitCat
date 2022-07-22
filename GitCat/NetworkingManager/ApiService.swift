//
//  ApiService.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 20/07/2022.
//

import Foundation
protocol ApiService {
    func getUsersList (completionHandler: @escaping (Result<[Users], Error>) -> Void)
//    func getUsersList(complition: @escaping (UsersListModel?, Error?)->Void)
}
