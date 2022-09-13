//
//  GitNetworkLogger.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 12/09/2022.
//
import Foundation
import Alamofire
class GitNetworkLogger: EventMonitor {
  let queue = DispatchQueue(label: "mostafa.GitCat.networklogger")
  func requestDidFinish(_ request: Request) {
    print(request.description)
  }
  func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
    guard let data = response.data else {
      return
    }
    if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
      print(json)
    }
  }
}
