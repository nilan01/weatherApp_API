//
//  CoreDataManager.swift
//  weatherApp_API
//
//  Created by user182271 on 11/26/20.
//

import Foundation
import CoreData

class CoreDataManager{
    
    static var shared = CoreDataManager()
    
    
    func insertNewLocation(city: String, country: String){
        
        let newLocation = Location(context: persistentContainer.viewContext)
        newLocation.city = city;
        newLocation.country = country;
        
        saveContext();
    }
    
    func fetchLocationsFromCoreData() -> [Location] {
        let fetch : NSFetchRequest = Location.fetchRequest()
        //fetch.sortDescriptors = [NSSortDescriptor]
        var result : [Location] = [Location]()
        do{
            result = try (persistentContainer.viewContext.fetch(fetch)as? [Location])!
        }catch{
            
        }
        return result
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "weatherApp_API")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
