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
    
    func save(name: String, notes: String, city: String, country: String, imageData: Data) {
        let place = Place(context: context)
        place.id = UUID()
        place.name = name
        place.city = city
        place.country = country
        place.notes = notes
        place.image = imageData
        
        saveContext()
    }
    
    func delete(id: UUID) {
        let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id=%@", id.uuidString)
        
        do {
            let fetchedPlaces = try context.fetch(fetchRequest)
            for pl in fetchedPlaces {
                context.delete(pl)
            }
            saveContext()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
