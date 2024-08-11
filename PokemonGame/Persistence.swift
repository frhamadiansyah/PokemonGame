//
//  Persistence.swift
//  PokemonGame
//
//  Created by Fandrian Rhamadiansyah on 09/08/24.
//

import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading core data: \(error)")
            }
        }
        context = container.viewContext
    }
    
    
    func save() async throws {
        if context.hasChanges {
            try await context.perform {
                do {
                    try self.context.save()
                } catch {
                    throw error
                    
                }
            }
        }
    }
    
    func delete(_ object: NSManagedObject) {
        context.delete(object)
    }
}
