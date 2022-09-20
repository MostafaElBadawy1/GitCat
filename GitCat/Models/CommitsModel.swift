//
//  CommitsModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 22/08/2022.
//
import Foundation
struct CommitsModel: Codable {
    let commit: Commit
    let html_url: String?
}
struct Commit: Codable{
    let committer: Committer?
    let message: String?
}
struct Committer: Codable{
    let name: String?
}
