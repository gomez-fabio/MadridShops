//
//  CoreDataStack.swift
//  CoreDataHelloWorld
//
//  Created by Fabio Gomez on 17/9/17.
//  Copyright © 2017 Fabio Gomez. All rights reserved.
//

import CoreData

public class CoreDataStack {
    public func createContainer(dbName: String) -> NSPersistentContainer  {
        let container = NSPersistentContainer(name: dbName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            print("💾 \(storeDescription.description)")  // para que me imprima la ruta a la bd sqlite
            if let error = error as NSError? {
                
                fatalError("💩 Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }
    
   public func saveContext (context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

