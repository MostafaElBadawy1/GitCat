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
    func fetchUserRepositories(completion: @escaping ([RepositoriesForUserModel]) -> Void) {
      sessionManager.request(GitRouter.fetchUserRepositories)
        .responseDecodable(of: [RepositoriesForUserModel].self) { response in
          guard let items = response.value else {
            return completion([])
          }
          completion(items)
        }
    }
    
    func searchRepositories(for query: String, completion: @escaping ([RepositoriesForUserModel]?, Error?) -> Void) {
        let url = "https://api.github.com/search/repositories"
        var queryParameters: [String: Any] = [ "sort": "stars", "order": "desc", "page": 1 ]
        queryParameters["q"] = query
        sessionManager.request(url, parameters: queryParameters).responseDecodable( of: SearchRepositoriesModel.self) { response in
            print(response)
            switch response.result {
            case .success(_):
                guard let items = response.value else {
                    return
                }
                print(items)
                completion(items.items, nil)
            case .failure(let error):
               // print(error)
                completion(nil, error)
            }
        }
    }
    func fetchAccessToken(accessCode: String, completion: @escaping (Bool) -> Void) {
      sessionManager.request(GitRouter.fetchAccessToken(accessCode))
        .responseDecodable(of: GitHubAccessToken.self) { response in
          guard let token = response.value else {
            return completion(false)
          }
          TokenManager.shared.saveAccessToken(gitToken: token)
          completion(true)
        }
    }


}
