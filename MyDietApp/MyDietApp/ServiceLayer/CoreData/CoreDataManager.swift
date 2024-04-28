//
//  CoreDataManager.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 22/04/24.
//

import CoreData
import UIKit

//MARK: - Protocol
protocol CoreDataManagerProtocol: AnyObject {
    var managedObjectContext: NSManagedObjectContext? { get }
    func saveObject<T: NSManagedObject>(object: T)
    func deleteObject<T: NSManagedObject>(object: T)
}

extension CoreDataManagerProtocol {
    func fetchRecipes(with predicate: NSPredicate) -> Result<[Recipe], DataBaseError> {
        guard let context = managedObjectContext else {
            return .failure(.couldNotLoadFromDatabase)
        }

        let fetchRequest: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        fetchRequest.predicate = predicate

        do {
            let recipeEntities = try context.fetch(fetchRequest)
            let recipes = recipeEntities.map { Recipe(from: $0) }
//            recipes.forEach {
//                print($0.mealType)
//            }
            return .success(recipes)
        } catch {
            return .failure(.couldNotLoadFromDatabase)
        }
    }
}

//MARK: - Implementation
final class CoreDataManager: CoreDataManagerProtocol {
    
    var managedObjectContext: NSManagedObjectContext?

    init() {
        setupManagedObjectContexts()
    }

    //MARK: Methods
    func getMainManagedObjectContext() -> NSManagedObjectContext? {
        guard let mainContext = managedObjectContext else { return nil }
        return mainContext
    }
    
    func saveObject<T: NSManagedObject>(object: T) {
        managedObjectContext?.perform { [weak self] in
            guard let self = self else { return }
            self.managedObjectContext?.insert(object)
            self.saveChanges()
        }
    }

    func deleteObject<T: NSManagedObject>(object: T) {
        managedObjectContext?.perform { [weak self] in
            guard let self = self else { return }
            if let objectInContext = self.managedObjectContext?.object(with: object.objectID) as? T {
                self.managedObjectContext?.delete(objectInContext)
            }
            self.saveChanges()
        }
    }
    
    //MARK: Private Methods
    private func setupManagedObjectContexts() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Unable to access AppDelegate")
            return
        }
        managedObjectContext = appDelegate.persistentContainer.viewContext
    }

    private func saveChanges() {
        guard let context = managedObjectContext else {
            return
        }
        try? context.save()
    }
}
