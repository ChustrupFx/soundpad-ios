import CoreData
import SwiftUI

class BaseModel<EntityType: NSManagedObject> {
    var object: EntityType
    var viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        self.object = EntityType(context: viewContext)
    }
    
    init(object: EntityType, viewContext: NSManagedObjectContext) {
        self.object = object
        self.viewContext = viewContext
    }
    
    func delete() {
        viewContext.delete(self.object)
    }
    
    func save() throws {
        if (viewContext.hasChanges) {
            try viewContext.save()
        }
    }
}

