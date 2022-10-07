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
    static let userListCellID = "UserListCell"
    static let userDetailsViewControllerID = "UserDetailsViewController"
    static let userDetailsTableViewCellID = "UserDetailsTableViewCell"
    static let repositoriesViewControllerID = "RepositoriesViewController"
    static let repositoriesTableViewCellID = "RepositoriesTableViewCell"
    static let commitsViewControllerID = "CommitsViewController"
    static let commitsTableViewCellID = "CommitsTableViewCell"
    static let settingsViewControllerID = "SettingsViewController"
    static let repositoriesForUserViewControllerID = "RepositoriesForUserViewController"
    static let recentSearchTableViewCellID = "RecentSearchTableViewCell"
    static let settingsTableViewCellID = "SettingsTableViewCell"
    static let recentVisitedUsersCollectionViewCellID = "RecentVisitedUsersCollectionViewCell"
    static let organizationsViewControllerID = "OrganizationsViewController"
    static let organizationsTableViewCellID = "OrganizationsTableViewCell"
    static let issuesViewControllerID = "IssuesViewController"
    static let webViewViewControllerID = "WebViewViewController"
    static let exploreViewControllerID = "ExploreViewController"
    static let exploreTableViewCellID = "ExploreTableViewCell"
    static let collectionViewTableViewCellID = "CollectionViewTableViewCell"
    static let loginViewControllerID = "LoginViewController"
    static let navigatingSearchTableViewCell = "NavigatingSearchTableViewCell"
    enum GitHubConstants {
        static let clientID = "a4256f5599e7f5ce4e5f"
        static let clientSecret = "2031d19a5bd10952d74f4db66ae7aa1f68b42a97"
        static let redirectURI = "gitcat"
        static let scope = "repo user"
        static let authorizeURL = "https://github.com/login/oauth/authorize"
    }
}
