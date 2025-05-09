import Foundation
import CoreData

extension CDChecklistItem {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDChecklistItem> {
        return NSFetchRequest<CDChecklistItem>(entityName: "CDChecklistItem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var title: String?
}

extension CDChecklistItem : Identifiable {}
