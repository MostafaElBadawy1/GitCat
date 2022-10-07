//
//  LoginViewController+Extention.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 07/10/2022.
//
import Foundation
import AuthenticationServices
// MARK: - ASWebAuthenticationPresentationContextProviding
extension LoginViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return view.window ?? ASPresentationAnchor()
    }
}
