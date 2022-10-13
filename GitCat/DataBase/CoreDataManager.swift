//
//  CoreDataManager.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 26/08/2022.
//
import UIKit
import CoreData
final class CoreDataManger {
    private init() {}
    static let shared = CoreDataManger()
    var usersArray = [User]()
    var reposArray = [Repo]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func fetch<T: NSManagedObject>(entityName: T.Type , completion: @escaping ([T]?, Error?) -> Void) {
        do {
            guard let result = try context.fetch(entityName.fetchRequest()) as? [T] else {
                return
            }
            completion(result, nil)
        } catch {
            completion(nil, error)
            print("Error In Saving")
        }
    }
    func delete<T: NSManagedObject>(entityName: T.Type, delete: T) {
        //        let usersRequest: NSFetchRequest<User> = User.fetchRequest()
        //        let reposRequest: NSFetchRequest<Repo> = Repo.fetchRequest()
        //        do {
        //            usersArray = try context.fetch(usersRequest)
        //            reposArray = try context.fetch(reposRequest)
        //        } catch {
        //            print("error")
        //        }
        context.delete(delete.self)
        do {
            try context.save()
        } catch {
            print("Error in deleting")
        }
    }
    //    func deleteAllEntities() {
    //        let entities = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.managedObjectModel.entities
    //        for i in entities {
    //            context.delete(i)
    //        }
    //    }
    //    func deleteAllEntities() {
    //        let entities = managedObjectModel.entities
    //        for entitie in entities {
    //          debugPrint("Deleting Entitie - ", entitie.name)
    //          delete(entityName: entitie.name!)
    //        }
    //      }
    func clearBookmarks() {
        // func deleteAllEntities() {
        //            let entities = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.managedObjectModel.entities
        //            for entity in entities {
        //                delete(entityName: User.self, delete: entity)
        //                delete(entityName: Repo.self, delete: entity)
        //            }
        
    }
}
//    func deleteEntityData(entity : String) {
//            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
//            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
//            do {
//                try CoreDataStack.sharedStack.mainContext.execute(deleteRequest)
//                CoreDataStack.sharedStack.saveMainContext()
//            } catch {
//                print ("There was an error")
//            }
//    }
//        usersArray.forEach { user in
//            print(user)
//            context.delete(user)
//            CoreDataManger.shared.delete(entityName: User.self, delete: user)
//            delete(entityName: User.self, delete: user)
//        }
//        reposArray.forEach { repo in
//            context.delete(repo)
//
//            delete(entityName: Repo.self, delete: repo)
//        }
//        usersArray = []
//        reposArray = []
//        try context.save()
//    }

