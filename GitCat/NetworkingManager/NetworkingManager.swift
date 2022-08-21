//
//  NetworkingManager.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 20/07/2022.
//

import UIKit
import Alamofire

class NetworkingManager: ApiService {
    static let shared = NetworkingManager()
    private init() {}
    func getUsersList(searchKeyword: String, page: Int) async throws -> SearchUsersModel {
        let url = URLs.shared.getUsersListURL(searchKeyword: searchKeyword, page: page)
        let (data,_) =  try await URLSession.shared.data(from: url!)
        return try JSONDecoder().decode(SearchUsersModel.self, from: data)
        }
    func getUserDetails(userName: String) async throws -> UserModel {
        let url = URLs.shared.getUserDetails(userName: userName)
        let (data,_) =  try await URLSession.shared.data(from: url!)
        return try JSONDecoder().decode(UserModel.self, from: data)
        }
    func getReposForUser(userName: String, pageNum: Int) async throws -> [RepositoriesForUserModel] {
        let url = URLs.shared.getReposForUser(userName: userName, pageNum: pageNum)
        let (data,_) =  try await URLSession.shared.data(from: url!)
        return try JSONDecoder().decode([RepositoriesForUserModel].self, from: data)
        }
    }

















//class NetworkingManager: ApiService {
//    static let shared = NetworkingManager()
//    private init() {}
//    func getUsersList<T: Codable>(model: T.Type) async throws -> T {
//        let url = URLs.shared.getUsersListURL()
//        let (data,_) =  try await URLSession.shared.data(from: url!)
//        //print(data)
//        let decodedArray = try JSONDecoder().decode(model, from: data)
//        print(decodedArray)
//        return decodedArray
//    }
//}


//class NetworkingManager: ApiService  {
    //static let shared = NetworkingManager()
//    func getUsersList (id:Int, completionHandler: @escaping (Result<[SearchUsersModel], Error>) -> Void) {
//        DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: {
//            guard let url = URLs.shared.getUsersListURL(id: id) else {return}
//            AF.request(url).response { response in
//                guard let data = response.data else {return}
//                do {
//                    let user = try JSONDecoder().decode([SearchUsersModel].self, from: data)
//                    completionHandler(.success(user))
//                } catch {
//                    completionHandler(.failure(error))
//                    print(error.localizedDescription)
//                }
//            }
//        })
//
//    }
//}
//        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response {response  in






//}
//    func getUsersList(complition: @escaping (UsersListModel?, Error?)->Void) {
//        guard  let url = URLs.shared.getUsersListURL() else {return}
//        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response { response in
//            switch response.result {
//            case .failure(let error):
//                print("error")
//                complition(nil, error)
//            case .success(_):
//                guard let data = response.data else {return}
//                print(data)
//                do{
//                    let json = try JSONDecoder().decode([UsersListModel].self, from: data)
//                    print(json)
//                 //   complition(json,nil)
//                    print("Got all User Successfully")
//                }catch let error{
//                    print("error while geting users")
//                    print(error)
//                    complition(nil,error)
//                }
//            }
//
//        }
//    }



//        func getUsersList(complition: @escaping (UsersListModel?, Error?)->Void) {
//            guard  let url = URLs.shared.getUsersListURL() else {return}
//            AF.request(url).response { response in
//                switch response.result {
//                case .failure(let error):
//                    print("error")
//                    complition(nil, error)
//                case .success(_):
//                    guard let data = response.data else {return}
//                    print(data)
//                    do{
//                        let json = try JSONDecoder().decode([UsersListModel].self, from: data)
//                        print(json)
//                       complition(json,nil)
//                        print("Got all User Successfully")
//                    }catch let error{
//                        print("error while geting users")
//                        print(error)
//                        complition(nil,error)
//                    }
//                }
//
//            }
//        }
//}
