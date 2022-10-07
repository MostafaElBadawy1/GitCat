//
//  APIManager.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 10/09/2022.
//
import UIKit
import Alamofire
class APIManager {
    static let shared = APIManager()
    let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.waitsForConnectivity = true
        let responseCacher = ResponseCacher(behavior: .modify { _, response in
            let userInfo = ["date": Date()]
            return CachedURLResponse(
                response: response.response,
                data: response.data,
                userInfo: userInfo,
                storagePolicy: .allowed)
        })
        let networkLogger = GitNetworkLogger()
        let interceptor = GitRequestInterceptor()
        return Session(
            configuration: configuration,
            interceptor: interceptor,
            cachedResponseHandler: responseCacher,
            eventMonitors: [networkLogger])
    }()
    func searchUsers(searchKeyword: String, pageNum: Int, completion: @escaping ([UserModel]?, Error?) -> Void) {
        sessionManager.request(GitRouter.searchUsers(searchKeyword, pageNum)).responseDecodable( of: SearchUsersModel.self) { response in
            switch response.result {
            case .success(_):
                guard let items = response.value else {
                    return
                }
                completion(items.items, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    func fetchSearchedUserProfile(userName: String, completion: @escaping (UserModel?, Error?) -> Void) {
        sessionManager.request(GitRouter.fetchSearchedUserProfile(userName)).responseDecodable(of: UserModel.self) { response in
            switch response.result {
            case .success(_):
                guard let items = response.value else {
                    return
                }
                completion(items,nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    func fetchUserProfile(completion: @escaping (UserModel?, Error?) -> Void) {
        sessionManager.request(GitRouter.fetchUserProfile).responseDecodable(of: UserModel.self) { response in
            switch response.result {
            case .success(_):
                guard let items = response.value else {
                    return
                }
                completion(items,nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    func fetchUserRepositories(repoOwner: String, pageNum: Int, completion: @escaping ([RepositoriesForUserModel]?, Error?) -> Void) {
        sessionManager.request(GitRouter.fetchUserRepositories(repoOwner, pageNum)).responseDecodable(of: [RepositoriesForUserModel].self) { response in
                switch response.result {
                case .success(_):
                    guard let repos = response.value else {
                        completion([], nil)
                        return
                    }
                    completion(repos, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
    func fetchStarredRepositories(userName: String, completion: @escaping ([RepositoriesForUserModel]?, Error?) -> Void) {
        sessionManager.request(GitRouter.fetchUserStarredRepositories(userName)).responseDecodable(of: [RepositoriesForUserModel].self) { response in
                switch response.result {
                case .success(_):
                    guard let repos = response.value else {
                        completion([], nil)
                        return
                    }
                    completion(repos, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
    func fetchMyRepositories( completion: @escaping ([RepositoriesForUserModel]?, Error?) -> Void) {
        sessionManager.request(GitRouter.fetchMyRepositories).responseDecodable(of: [RepositoriesForUserModel].self) { response in
                switch response.result {
                case .success(_):
                    guard let repos = response.value else {
                        completion([], nil)
                        return
                    }
                    completion(repos, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
    func searchRepositories(for repoName: String, pageNum: Int, completion: @escaping ([RepositoriesForUserModel]?, Error?) -> Void) {
        sessionManager.request(GitRouter.searchRepositories(repoName, pageNum)).responseDecodable( of: SearchRepositoriesModel.self) { response in
            switch response.result {
            case .success(_):
                guard let repos = response.value else {
                    return
                }
                completion(repos.items, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    func searchIssues(searchWord: String, pageNum: Int, completion: @escaping ([IssuesItems]?, Error?) -> Void) {
        sessionManager.request(GitRouter.searchIssues(searchWord, pageNum)).responseDecodable( of: IssuesModel.self) { response in
            switch response.result {
            case .success(_):
                guard let issues = response.value else {
                    return
                }
                completion(issues.items, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    func fetchCommits(ownerName: String, repoName: String, pageNum: Int, completion: @escaping ([CommitsModel]?, Error?) -> Void) {
        sessionManager.request(GitRouter.fetchCommits(ownerName, repoName, pageNum)).responseDecodable( of: [CommitsModel].self) { response in
            switch response.result {
            case .success(_):
                guard let commits = response.value else {
                    return
                }
                completion(commits, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    func searchExploreRepos(searchWord: String, pageName: Int, completion: @escaping ([RepositoriesForUserModel]?, Error?) -> Void) {
        sessionManager.request(GitRouter.exploreRepos(searchWord, pageName)).responseDecodable( of: SearchRepositoriesModel.self) { response in
            switch response.result {
            case .success(_):
                guard let items = response.value else {
                    return
                }
                completion(items.items, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    func fetchUsersOrgs(userName: String, completion: @escaping ([OrganizationModel]?, Error?) -> Void) {
        sessionManager.request(GitRouter.fetchUserOrgs(userName)).responseDecodable( of: [OrganizationModel].self) { response in
            switch response.result {
            case .success(_):
                guard let items = response.value else {
                    return
                }
                completion(items, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    func fetchMyRepo(completion: @escaping (RepositoriesForUserModel?, Error?) -> Void) {
        sessionManager.request(GitRouter.fetchMyRepo).responseDecodable(of: RepositoriesForUserModel.self) { response in
                switch response.result {
                case .success(_):
                    guard let repo = response.value else {
                        return
                    }
                    completion(repo, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
    func fetchAccessToken(accessCode: String, completion: @escaping (Bool) -> Void) {
        sessionManager.request(GitRouter.fetchAccessToken(accessCode)).responseDecodable(of: GitHubAccessToken.self) { response in
                guard let token = response.value else {
                    return completion(false)
                }
                TokenManager.shared.saveAccessToken(gitToken: token)
                completion(true)
            }
    }
}
