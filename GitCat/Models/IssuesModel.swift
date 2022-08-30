//
//  IssuesModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 30/08/2022.
//
import Foundation
struct IssuesModel: Codable {
    let items : [IssuesItems]
}
struct IssuesItems: Codable {
    let title : String
    let state : String
}
