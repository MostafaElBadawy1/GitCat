//
//  SearchRepositoriesModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 22/08/2022.
//
import Foundation
struct SearchRepositoriesModel: Codable{
    let items: [RepoItems]
}
struct RepoItems: Codable{
    let name: String?
    let full_name: String?
    let owner: RepoOwner?
    let description: String?
    let stargazers_count: Int?
    let language: String?
}
struct RepoOwner: Codable{
    let login: String?
    let avatar_url: String?
    let html_url: String?
}
