//
//  SplashViewModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 07/10/2022.
//
import Foundation
class SplashViewModel {
    var isLoggedIn: Bool {
      if TokenManager.shared.fetchAccessToken() != nil {
        return true
      }
      return false
    }
}
