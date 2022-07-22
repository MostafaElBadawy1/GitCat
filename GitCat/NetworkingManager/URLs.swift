//
//  URLs.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 20/07/2022.
//

import Foundation

struct URLs {
    static let shared = URLs()
    let baseURL = "https://api.github.com/"
    func getUsersListURL()->URL?{
        return URL(string: baseURL + "users")
    }
    func getDetailedUser(userName: String)->URL?{
        return URL(string: baseURL + "users\(userName)")
    }
}
