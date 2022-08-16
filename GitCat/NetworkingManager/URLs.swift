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
    func getUsersListURL(searchKeyword: String, page:Int)->URL?{
        return URL(string: baseURL + "search/users?q=\(searchKeyword)&page=\(page)")
        //return URL(string: baseURL + "users?since=\(id)&per_page=20")
    }
//    func getUserDetails(userName: String)->URL?{
//        return URL(string: baseURL + "users\(userName)")
//    }
}
//https://api.github.com/search/users?q=e&page=5
