//
//  NetworkingManager.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 20/07/2022.
//

import Foundation
import Alamofire

class NetworkingManager: ApiService  {
    static let shared = NetworkingManager()
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
    func getUsersList (completionHandler: @escaping (Result<[Users], Error>) -> Void) {
        guard let url = URLs.shared.getUsersListURL() else {return}
//        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response {response  in
        AF.request(url).response { response in
            guard let data = response.data else {return}
            do {
                let user = try JSONDecoder().decode([Users].self, from: data)
                completionHandler(.success(user))
            } catch {
                completionHandler(.failure(error))
                print(error.localizedDescription)
            }
        }
    }
}
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
