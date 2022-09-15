//
//  GitNetworkReachability.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 13/09/2022.
//
import UIKit
import Alamofire
class GitNetworkReachability {
  static let shared = GitNetworkReachability()
  let reachabilityManager = NetworkReachabilityManager(host: "www.google.com")
  let offlineAlertController: UIAlertController = {
    UIAlertController(title: "No Network", message: "Please connect to network and try again", preferredStyle: .alert)
  }()
  func startNetworkMonitoring() {
    reachabilityManager?.startListening { status in
      switch status {
      case .notReachable:
        self.showOfflineAlert()
      case .reachable(.cellular):
        self.dismissOfflineAlert()
      case .reachable(.ethernetOrWiFi):
        self.dismissOfflineAlert()
      case .unknown:
        print("Unknown network state")
      }
    }
  }
  func showOfflineAlert() {
    let rootViewController = UIApplication.shared.windows.first?.rootViewController
    rootViewController?.present(offlineAlertController, animated: true, completion: nil)
  }

  func dismissOfflineAlert() {
    let rootViewController = UIApplication.shared.windows.first?.rootViewController
    rootViewController?.dismiss(animated: true, completion: nil)
  }
}
