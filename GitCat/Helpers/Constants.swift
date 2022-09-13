//
//  Constants.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 04/08/2022.
//
import Foundation
struct K {
    static let tabBarID = "TabBarController"
    static let homeTableViewCell = "HomeTableViewCell"
    static let usersListViewControllerID = "UsersListViewController"
    static let usersListTableViewCell = "UsersListTableViewCell"
    static let UserListCellID = "UserListCell"
    static let UserDetailsViewControllerID = "UserDetailsViewController"
    static let UserDetailsTableViewCellID = "UserDetailsTableViewCell"
    static let RepositoriesViewControllerID = "RepositoriesViewController"
    static let RepositoriesTableViewCellID = "RepositoriesTableViewCell"
    static let CommitsViewControllerID = "CommitsViewController"
    static let CommitsTableViewCellID = "CommitsTableViewCell"
    static let SettingsViewControllerID = "SettingsViewController"
    static let RepositoriesForUserViewControllerID = "RepositoriesForUserViewController"
    static let RecentSearchTableViewCellID = "RecentSearchTableViewCell"
    static let SettingsTableViewCellID = "SettingsTableViewCell"
    static let RecentVisitedUsersCollectionViewCellID = "RecentVisitedUsersCollectionViewCell"
    static let OrganizationsViewControllerID = "OrganizationsViewController"
    static let OrganizationsTableViewCellID = "OrganizationsTableViewCell"
    static let IssuesViewControllerID = "IssuesViewController"
    static let WebViewViewControllerID = "WebViewViewController"
    static let ExploreViewControllerID = "ExploreViewController"
    static let ExploreTableViewCellID = "ExploreTableViewCell"
    static let CollectionViewTableViewCellID = "CollectionViewTableViewCell"
    static let loginViewControllerID = "LoginViewController"
    enum GitHubConstants {
        static let clientID = "a4256f5599e7f5ce4e5f"
        static let clientSecret = "2031d19a5bd10952d74f4db66ae7aa1f68b42a97"
        static let redirectURI = "gitcat"
        static let scope = "repo user"
        static let authorizeURL = "https://github.com/login/oauth/authorize"
    }
}
