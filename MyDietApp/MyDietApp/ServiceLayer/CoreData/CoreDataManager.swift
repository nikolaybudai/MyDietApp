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
    func saveObject<T: NSManagedObject>(object: T)
    func deleteObject<T: NSManagedObject>(object: T)
}

//MARK: - Implementation
final class CoreDataManager: CoreDataManagerProtocol {
    private var mainManagedObjectContext: NSManagedObjectContext?
    private var privateManagedObjectContext: NSManagedObjectContext?

    init() {
        setupManagedObjectContexts()
    }

    //MARK: Methods
    func saveObject<T: NSManagedObject>(object: T) {
        privateManagedObjectContext?.perform { [weak self] in
            guard let self = self else { return }
            self.privateManagedObjectContext?.insert(object)
            self.saveChanges()
        }
    }

    func deleteObject<T: NSManagedObject>(object: T) {
        privateManagedObjectContext?.perform { [weak self] in
            guard let self = self else { return }
            if let objectInContext = self.privateManagedObjectContext?.object(with: object.objectID) as? T {
                self.privateManagedObjectContext?.delete(objectInContext)
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
        mainManagedObjectContext = appDelegate.persistentContainer.viewContext
        privateManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateManagedObjectContext?.parent = mainManagedObjectContext
    }

    private func saveMainContext() {
        guard let mainContext = mainManagedObjectContext else {
            print("Main managed object context is nil")
            return
        }
        do {
            try mainContext.save()
        } catch {
            print("Error saving main managed object context: \(error)")
        }
    }

    private func savePrivateContext() {
        guard let privateContext = privateManagedObjectContext else {
            print("Private managed object context is nil")
            return
        }
        do {
            try privateContext.save()
        } catch {
            print("Error saving private managed object context: \(error)")
        }
    }

    private func saveChanges() {
        savePrivateContext()
        mainManagedObjectContext?.performAndWait {
            saveMainContext()
        }
    }
}
