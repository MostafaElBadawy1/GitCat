//
//  SearchUsersModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 12/08/2022.
//
import Foundation
struct SearchUsersModel: Codable {
    let items: [Items]
}
struct Items: Codable {
    let login: String
    let avatar_url: String
    let url, html_url : String
    let id: Int
}
