import Foundation
import CoreData

final class CoreDataStack {
    
    static let shared = CoreDataStack()
    private init() {}
    
    // Имя модели .xcdatamodeld
    private let modelName = "FitnessAppModel"
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Core Data failed to load: \(error), \(error.userInfo)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    var context: NSManagedObjectContext { persistentContainer.viewContext }
    
    // MARK: - Save
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Core Data save error: \(error)")
            }
        }
    }
    
    // MARK: - Generic Fetch
    func fetch<T: NSManagedObject>(_ type: T.Type,
                                   predicate: NSPredicate? = nil,
                                   sortDescriptors: [NSSortDescriptor]? = nil) -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        do {
            return try context.fetch(request)
        } catch {
            print("Core Data fetch error: \(error)")
            return []
        }
    }
    
    // MARK: - Delete
    func delete(_ object: NSManagedObject) {
        context.delete(object)
        saveContext()
    }
    
    func deleteAll<T: NSManagedObject>(_ type: T.Type) {
        let objects = fetch(type)
        objects.forEach { context.delete($0) }
        saveContext()
    }
}
