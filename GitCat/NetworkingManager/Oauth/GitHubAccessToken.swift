//
//  GitHubAccessToken.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 12/09/2022.
//
import Foundation
struct GitHubAccessToken: Decodable {
  let accessToken: String
  let tokenType: String

  enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case tokenType = "token_type"
  }
}
