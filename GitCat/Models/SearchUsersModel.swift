//
//  SearchUsersModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 12/08/2022.
//

import Foundation

// MARK: - Users
struct SearchUsersModel: Codable {
//    let totalCount: Int
//    let incompleteResults: Bool
    let items: [Items]
    
//    enum CodingKeys: String, CodingKey {
//        case totalCount = "total_count"
//        case incompleteResults = "incomplete_results"
//        case SearchUsers
//    }
}
// MARK: - Item
struct Items: Codable {
    let login: String
    let avatar_url: String
    let url, html_url : String
//    let id: Int
//    let nodeID: String
//    let gravatarID: String
//    let followingURL, followersURL, gistsURL, starredURL: String
//    let subscriptionsURL, organizationsURL, reposURL: String
//    let eventsURL: String
//    let receivedEventsURL: String
// let siteAdmin: Bool
// let score: Int

   // enum CodingKeys: String, CodingKey {
  //      case login = "login"
//        case id = "id"
//        case nodeID = "node_id"
 //       case avatarURL = "avatar_url"
//        case gravatarID = "gravatar_id"
//        case url = "url"
//        case htmlURL = "html_url"
//        case followersURL = "followers_url"
//        case followingURL = "following_url"
//        case gistsURL = "gists_url"
//        case starredURL = "starred_url"
//        case subscriptionsURL = "subscriptions_url"
//        case organizationsURL = "organizations_url"
//        case reposURL = "repos_url"
//        case eventsURL = "events_url"
//        case receivedEventsURL = "received_events_url"
//        case siteAdmin = "site_admin"
//        case score
   // }
}
