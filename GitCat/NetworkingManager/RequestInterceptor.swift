//
//  GitRequestInterceptor.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 12/09/2022.
//
import Foundation
import Alamofire
class GitRequestInterceptor: RequestInterceptor {
  let retryLimit = 5
  let retryDelay: TimeInterval = 10
    
  func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
    var urlRequest = urlRequest
      print(urlRequest)
    if let token = TokenManager.shared.fetchAccessToken() {
      urlRequest.setValue("token \(token)", forHTTPHeaderField: "Authorization")
    }
    completion(.success(urlRequest))
  }
    
  func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
    let response = request.task?.response as? HTTPURLResponse
    //Retry for 5xx status codes
    if
      let statusCode = response?.statusCode,
      (500...599).contains(statusCode),
      request.retryCount < retryLimit {
        completion(.retryWithDelay(retryDelay))
    } else {
      return completion(.doNotRetry)
    }
  }
}
