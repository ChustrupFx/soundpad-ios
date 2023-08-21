import CoreData

class BaseModel<EntityType: NSManagedObject> {
    
    var object: EntityType
    var viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        self.object = EntityType(context: viewContext)
    }
    
    func delete() throws {
        viewContext.delete(self.object)
    }
    
    func save() throws {
        if (viewContext.hasChanges) {
            try viewContext.save()
        }
    }
    
}
