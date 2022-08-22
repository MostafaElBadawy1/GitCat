//
//  StarredReposModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 22/08/2022.
//
import Foundation
struct StarredReposModel:Codable {
    let name: String?
    let full_name: String?
    let description: String?
    let stargazers_count: String?
    let language: String?
}
