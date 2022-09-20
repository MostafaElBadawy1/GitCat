//
//  URLs.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 20/07/2022.
//
//import Foundation
//struct URLs {
//    static let shared = URLs()
//    let baseURL = "https://api.github.com/"
//    func searchUsersURL(searchKeyword: String, page:Int)->URL?{
//        return URL(string: baseURL + "search/users?q=\(searchKeyword)&page=\(page)")
//    }
//    func getUserDetailsURL(userName: String)->URL?{
//        return URL(string: baseURL + "users/\(userName)")
//    }
//    func getReposForUserURL(userName: String, pageNum: Int)->URL?{
//        return URL(string: baseURL + "users/\(userName)/repos?page=\(pageNum)")
//    }
//    func getCommitsForRepoURL(ownerName: String, repoName: String, pageNum: Int)->URL?{
//        return URL(string: baseURL + "repos/\(ownerName)/\(repoName)/commits?page=\(pageNum)")
//    }
//    func searchReposURL(searchKeyword: String, pageNum: Int)->URL?{
//        return URL(string: baseURL + "search/repositories?q=\(searchKeyword)&page=\(pageNum)")
//    }
//    func getUserOrgs(userName: String)->URL?{
//        return URL(string: baseURL + "users/\(userName)/orgs")
//    }
//    func searchIssuesURL(searchWord: String, pageNum: Int) -> URL? {
//        return URL(string: baseURL + "search/issues?q=\(searchWord)&page=\(pageNum)")
//    }
//    func getExploreReposURL(pageNum: Int)->URL?{
//        return URL (string: baseURL + "search/repositories?q=+language:swift&page=\(pageNum)&sort=stars")
//    }
//    func getMyRepo()->URL?{
//        return URL (string: baseURL + "repos/MostafaElBadawy1/GitCat")
//    }
//}


//https://api.github.com/search/users?q=e&page=5
//https://api.github.com/users/USERNAME
//https://api.github.com/users/mo/repos?page=2
//https://api.github.com/repos/mo/abortcontroller-polyfill/commits?page=1
//https://api.github.com/search/repositories?q=a&page=2
//https://api.github.com/users/mojombo/orgs
//https://api.github.com/users/eFiniLan/starred?page=1
//https://api.github.com/users/mojombo/orgs
//https://api.github.com/search/issues?q=s&page=1
//https://api.github.com/search/repositories?q=+language:swift&page=1&sort=stars
//https://api.github.com/repos/MostafaElBadawy1/GitCat
