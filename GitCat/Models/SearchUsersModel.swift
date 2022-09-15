//
//  SearchUsersModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 12/08/2022.
//
import Foundation
struct SearchUsersModel: Codable {
    let items: [UserModel]
}
struct UserModel: Codable {
    let login: String?
    let id: Int?
    let avatar_url: String?
    let gravatar_id: String?
    let url, html_url, followers_url: String?
    let following_url, gists_url, starred_url: String?
    let subscriptions_url, organizations_url, repos_url: String?
    let events_url: String?
    let name: String?
    let blog: String?
    let location: String?
    let bio: String?
    let public_repos, public_gists, followers, following: Int?
    //let created_at, updated_at: Date?
}
