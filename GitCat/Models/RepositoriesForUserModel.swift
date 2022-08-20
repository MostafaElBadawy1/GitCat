//
//  RepositoriesForUserModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 20/08/2022.
//

import Foundation
struct RepositoriesForUserModel: Codable {
    let name: String
    let description: String?
    let stargazers_count: Int
    let language: String
        
}
