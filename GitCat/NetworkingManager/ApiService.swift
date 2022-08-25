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
    func searchRepos(userName: String, pageNum: Int) async throws-> SearchRepositoriesModel
    func getStarredRepos(userName: String,  pageNum: Int) async throws-> [StarredReposModel]
    func getUserOrgs(userName: String) async throws-> [OrganizationModel]
}
//    func getUsersList<T: Codable>(model: T.Type) async throws -> T
//    func getUsersList (id:Int, completionHandler: @escaping (Result<[SearchUsersModel], Error>) -> Void)
//    func getUsersList(complition: @escaping (UsersListModel?, Error?)->Void)

