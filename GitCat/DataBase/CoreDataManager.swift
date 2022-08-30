//
//  CoreDataManager.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 26/08/2022.
//
import CoreData
import UIKit
class CoreDataManger {
    static let shared = CoreDataManger()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func fetch<T: NSManagedObject>(entityName: T.Type , completion: @escaping ([T]) -> Void) {
        do {
            guard let result = try context.fetch(entityName.fetchRequest()) as? [T] else {
                return
            }
            completion(result)
        } catch {
            print("Error In Saving")
        }
        
    }
    func delete<T: NSManagedObject>(entityName: T.Type, delete: T) {
        context.delete(delete.self)
        do {
            try context.save()
        } catch {
            print("Error in deleting")
        }
    }
}
