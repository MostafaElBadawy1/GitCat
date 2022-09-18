//
//  BookmarksViewModel.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 29/08/2022.
//
import UIKit
import CoreData
class BookmarksViewModel {
    var bindingData: (([User]?,Error?) -> Void) = {_, _ in }
    var users : [User]? {
        didSet {
            bindingData(users,nil)
        }
    }
    var bindingReposData: (([Repo]?,Error?) -> Void) = {_, _ in }
    var repos : [Repo]? {
        didSet {
            bindingReposData(repos,nil)
        }
    }
    var error: Error!{
        didSet {
            bindingData(nil, error)
            bindingReposData(nil, error)
        }
    }
    func fetchBookmarkedUsers() {
        CoreDataManger.shared.fetch(entityName: User.self) { (users, error) in
            if let usersData = users {
                DispatchQueue.main.async {
                    self.users = usersData
                }
            }
            switch error {
            case .some(let error):
                self.error = error
            case .none :
                return
            }
        }
    }
    func fetchBookmarkedReposs() {
        CoreDataManger.shared.fetch(entityName: Repo.self) { (repos, error) in
            if let reposData = repos {
                DispatchQueue.main.async {
                    self.repos = reposData
                }
            }
            switch error {
            case .some(let error):
                self.error = error
            case .none :
                return
            }
        }
    }
    func deleteItem<T: NSManagedObject>(entityName: T.Type, delete: T) {
        CoreDataManger.shared.delete(entityName: entityName, delete: delete)
    }
}
