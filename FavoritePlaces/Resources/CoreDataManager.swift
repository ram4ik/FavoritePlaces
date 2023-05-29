//
//  CoreDataManager.swift
//  FavoritePlaces
//
//  Created by Ramill Ibragimov on 29.05.2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoritePlacesDataModel")
        container.loadPersistentStores { _, error in
            if let error = error as? NSError {
                fatalError("Error: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch let err {
                let error = err as NSError
                fatalError("Error saving context \(error), \(error.userInfo)")
            }
        }
    }
    
    func getAll() -> [Place] {
        var places = [Place]()
        let placeRequest: NSFetchRequest<Place> = Place.fetchRequest()
        
        do {
            places = try context.fetch(placeRequest)
        } catch let err as NSError {
            print(err.localizedDescription)
        }
        
        return places
    }
}
