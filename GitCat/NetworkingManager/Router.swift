//
//  GitRouter.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 13/09/2022.
//
import Foundation
import Alamofire
enum GitRouter {
    case fetchUserRepositories
    case searchRepositories(String)
    case fetchCommits(String)
    case fetchAccessToken(String)
    case fetchUserProfile
    case searchUsers(String,Int)
    case fetchSearchedUserProfile(String)
    case searchIssues(String, Int)
    case exploreRepos(String, Int)
    var baseURL: String {
        switch self {
        case .fetchUserRepositories, .searchRepositories, .fetchCommits, .fetchUserProfile, .searchUsers, .fetchSearchedUserProfile, .searchIssues, .exploreRepos:
            return "https://api.github.com"
        case .fetchAccessToken:
            return "https://github.com"
        }
    }
    var path: String {
        switch self {
        case .fetchUserProfile:
            return "user"
        case .fetchSearchedUserProfile(let userName):
            return "users/\(userName)"
        case .searchUsers:
            return "search/users"
        case .fetchUserRepositories:
            return "/user/repos"
        case .searchRepositories:
            return "/search/repositories"
        case .fetchCommits(let repository):
            return "/repos/\(repository)/commits"
        case .exploreRepos:
            return "/search/repositories"
        case .searchIssues:
            return "search/issues"
        case .fetchAccessToken:
            return "/login/oauth/access_token"
        }
    }
    var method: HTTPMethod {
        switch self {
        case .fetchUserRepositories, .fetchUserProfile, .searchUsers, .fetchSearchedUserProfile,
                .searchIssues, .exploreRepos, .searchRepositories, .fetchCommits:
            return .get
        case .fetchAccessToken:
            return .post
        }
    }
    var parameters: [String: String]? {
        switch self {
        case .searchUsers(let searchWord, let pageNum):
            return ["q": searchWord, "page": "\(pageNum)","per_page": "30" ]
        case .fetchUserRepositories:
            return ["per_page": "30"]
        case .searchRepositories(let query):
            return ["sort": "stars", "order": "desc", "page": "1", "q": query]
        case .searchIssues(let issue, let pageNum):
            return ["q": issue, "page": "\(pageNum)","per_page": "30" ]
        case .exploreRepos(let searchWord, let pageName):
            return ["q": "\(searchWord).language:swift", "page": "\(pageName)", "sort": "stars", ]
        case .fetchCommits, .fetchUserProfile, .fetchSearchedUserProfile:
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
