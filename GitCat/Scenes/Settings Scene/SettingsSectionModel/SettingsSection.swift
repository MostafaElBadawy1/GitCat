//
//  SettingsSection.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 10/08/2022.
//
enum SettingsSection: Int , CaseIterable, CustomStringConvertible{
    case General
    case Policy
    case Language
    case Account
    var description: String {
        switch self {
        case .General:
            return "General"
        case .Policy:
            return "Policy"
        case .Language:
            return "Language"
        case .Account:
            return "Account"
        }
    }
}
enum GeneralOptions: Int, CaseIterable, CustomStringConvertible {
    case darkMode
    case removeAllRecords
    case removeAllBookmarks
    var description: String {
        switch self {
        case .darkMode:
            return "Dark Mode"
        case .removeAllRecords:
            return "Remove All Records"
        case .removeAllBookmarks:
            return "Remove All Bookmarks"
        }
    }
}
enum PolicyOptions: Int, CaseIterable, CustomStringConvertible {
    case privacyPolicy
    case termsOfUse
    var description: String {
        switch self {
        case .privacyPolicy:
            return "Privacy Policy"
        case .termsOfUse:
            return "Terms Of Use"
        }
    }
}
enum LanguageOptions: Int, CaseIterable, CustomStringConvertible {
    case switchLanguageToArabic
    var description: String {
        switch self {
        case .switchLanguageToArabic:
            return "تحويل اللغة إلي اللغة العربية"
        }
    }
}
enum AccountOptions: Int, CaseIterable, CustomStringConvertible {
    case logOut
    var description: String {
        switch self {
        case .logOut:
            return "Log Out"
        }
    }
}
