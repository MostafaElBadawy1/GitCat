//
//  ApiService.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 20/07/2022.
//
protocol ApiService {
    func searchUsers(searchKeyword: String, page: Int) async throws -> SearchUsersModel
    func getUserDetails(userName: String) async throws -> UserModel
    func getReposForUser(userName: String, pageNum: Int) async throws -> [RepositoriesForUserModel]
    func getCommitsForRepo(ownerName: String, repoName: String, pageNum: Int) async throws-> [CommitsModel]
    func searchRepos(searchKeyword: String, pageNum: Int) async throws-> SearchRepositoriesModel
    func getUserOrgs(userName: String) async throws-> [OrganizationModel]
    func searchIssues(searchWord: String, pageNum: Int) async throws-> IssuesModel
    func getExploreRepos(pageNum: Int) async throws-> SearchRepositoriesModel
    func getMyRepo() async throws-> MyRepo
}
//    func getUsersList<T: Codable>(model: T.Type) async throws -> T
//    func getUsersList (id:Int, completionHandler: @escaping (Result<[SearchUsersModel], Error>) -> Void)
//    func getUsersList(complition: @escaping (UsersListModel?, Error?)->Void)

// func getStarredRepos(userName: String,  pageNum: Int) async throws-> [StarredReposModel]
