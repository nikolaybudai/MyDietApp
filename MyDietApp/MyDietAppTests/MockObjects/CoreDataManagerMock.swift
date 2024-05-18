//
//  CoreDataManagerMock.swift
//  MyDietAppTests
//
//  Created by Nikolay Budai on 10/05/24.
//

import CoreData
@testable import MyDietApp

class CoreDataManagerMock: CoreDataManagerProtocol {
    
    var managedObjectContext: NSManagedObjectContext?
    
    func saveObject<T>(object: T) where T : NSManagedObject {
        
    }
    
    func deleteObject<T>(object: T) where T : NSManagedObject {
        
    }
    
}
