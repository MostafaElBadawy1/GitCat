//
//  RepositoriesForUserModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 20/08/2022.
//
import Foundation
struct RepositoriesForUserModel: Codable {
    let name: String?
    let full_name: String?
    let description: String?
    let stargazers_count: Int?
    let language: String?
    let owner: Owner?
}
struct Owner: Codable {
    let avatar_url: String?
    let login: String?
}
