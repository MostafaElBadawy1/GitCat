//
//  MyRepo.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 31/08/2022.
//
import Foundation
struct MyRepo: Codable {
    let name: String?
    let owner: OwnerOfRepo?
}
 struct OwnerOfRepo: Codable {
    let avatar_url: String?
}
