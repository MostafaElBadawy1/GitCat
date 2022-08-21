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
    func getUserDetails(userName: String)->URL?{
        return URL(string: baseURL + "users/\(userName)")
    }
    func getReposForUser(userName: String, pageNum: Int)->URL?{
      return URL(string: baseURL + "users/\(userName)/repos?page=\(pageNum)")
    }
}
//https://api.github.com/search/users?q=e&page=5
//https://api.github.com/users/USERNAME
//https://api.github.com/users/mo/repos
//https://api.github.com/users/mo/repos?page=2
