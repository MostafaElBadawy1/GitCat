//
//  GitRouter.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 13/09/2022.
//
import Foundation
import Alamofire
enum GitRouter {
    case fetchUserRepositories(String, Int)
    case fetchUserStarredRepositories(String)
    case fetchMyRepositories
    case searchRepositories(String, Int)
    case fetchCommits(String, String, Int)
    case fetchAccessToken(String)
    case fetchUserProfile
    case searchUsers(String,Int)
    case fetchSearchedUserProfile(String)
    case searchIssues(String, Int)
    case exploreRepos(String, Int)
    case fetchUserOrgs(String)
    case fetchMyRepo
    var baseURL: String {
        switch self {
        case .fetchUserRepositories, .fetchUserStarredRepositories, .fetchMyRepositories, .searchRepositories, .fetchCommits, .fetchUserProfile, .searchUsers, .fetchSearchedUserProfile, .searchIssues, .exploreRepos, .fetchUserOrgs, .fetchMyRepo:
            return "https://api.github.com/"
        case .fetchAccessToken:
            return "https://github.com"
        }
    }
    var path: String {
        switch self {
        case .fetchUserProfile: //x
            return "user"
        case .fetchMyRepositories:
            return "user/repos"
        case .fetchSearchedUserProfile(let userName): //x
            return "users/\(userName)"
        case .searchUsers:
            return "search/users"
        case .fetchUserRepositories (let repoOwner, _):
            return "users/\(repoOwner)/repos"
        case .fetchUserStarredRepositories (let userName):
            return "users/\(userName)/starred"
        case .searchRepositories:
            return "/search/repositories"
        case .fetchCommits(let ownerName,let repository, _):
            return "/repos/\(ownerName)/\(repository)/commits"
        case .exploreRepos:
            return "/search/repositories"
        case .searchIssues: //x //D
            return "search/issues"
        case .fetchUserOrgs(let userName):
            return "users/\(userName)/orgs"
        case .fetchMyRepo:                  //x
            return "repos/MostafaElBadawy1/GitCat"
        case .fetchAccessToken:
            return "/login/oauth/access_token"
        }
    }
    var method: HTTPMethod {
        switch self {
        case .fetchUserRepositories, .fetchUserStarredRepositories, .fetchMyRepositories, .fetchUserProfile, .searchUsers, .fetchSearchedUserProfile,
                .searchIssues, .exploreRepos, .searchRepositories, .fetchCommits, .fetchUserOrgs, .fetchMyRepo:
            return .get
        case .fetchAccessToken:
            return .post
        }
    }
    var parameters: [String: String]? {
        switch self {
        case .searchUsers(let searchWord, let pageNum):
            return ["q": searchWord, "page": "\(pageNum)","per_page": "30" ]
        case .fetchUserRepositories(_, let pageNum):
            return ["page": "\(pageNum)"]
        case .fetchUserStarredRepositories:
            return ["per_page": "100"]
        case .searchRepositories(let repoName, let pageNum):
            return ["sort": "stars", "order": "desc", "page": "\(pageNum)", "q": repoName]
        case .searchIssues(let issue, let pageNum):
            return ["q": issue, "page": "\(pageNum)","per_page": "30" ]
        case .exploreRepos(let searchWord, let pageName):
            return ["q": "\(searchWord).language:swift", "page": "\(pageName)", "sort": "stars", ]
        case .fetchMyRepositories:
            return ["per_page": "50"]
        case .fetchCommits(_,_,let pageNum):
            return ["page":"\(pageNum)"]
        case .fetchUserProfile, .fetchSearchedUserProfile, .fetchUserOrgs, .fetchMyRepo:
            return nil
        case .fetchAccessToken(let accessCode):
            return [
                "client_id": K.GitHubConstants.clientID,
                "client_secret": K.GitHubConstants.clientSecret,
                "code": accessCode
            ]
        }
    }
}
// MARK: - URLRequestConvertible
extension GitRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL().appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        if method == .get {
            request = try URLEncodedFormParameterEncoder()
                .encode(parameters, into: request)
        } else if method == .post {
            request = try JSONParameterEncoder().encode(parameters, into: request)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
        }
        return request
    }
}
