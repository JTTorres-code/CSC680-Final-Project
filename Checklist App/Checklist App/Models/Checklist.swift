//
//  Checklist.swift
//  Checklist App
//
//  Created by Jacob Torres on 5/12/25.
//

import Foundation
import CoreData

struct Checklist: Identifiable, Codable {
    let id: UUID
    var name: String
    var emoji: String?
    var items: [ChecklistItem]

    init(id: UUID = UUID(), name: String, emoji: String? = nil, items: [ChecklistItem] = []) {
            self.id = id
            self.name = name
            self.emoji = emoji
            self.items = items
        }
}

// MARK: - Core Data Conversion
extension Checklist {
    
    /// Converts this `Checklist` model to a `CDChecklist` Core Data object
    func toManagedObject(context: NSManagedObjectContext) -> CDChecklist {
        let checklistEntity = CDChecklist(context: context)
        checklistEntity.id = self.id
        checklistEntity.name = self.name
        checklistEntity.emoji = self.emoji
        
        let itemEntities = self.items.map { item -> CDChecklistItem in
            let itemEntity = item.toManagedObject(context: context)
            itemEntity.checklist = checklistEntity
            return itemEntity
        }
        
        checklistEntity.items = Set(itemEntities) as NSSet
        return checklistEntity
    }
    
    
    /// Converts a `CDChecklist` Core Data object back into a `Checklist` model
    static func fromManagedObject(_ entity: CDChecklist) -> Checklist {
        let itemsArray: [ChecklistItem] = (entity.items as? Set<CDChecklistItem>)?.map {
            ChecklistItem.fromManagedObject($0)
        } ?? []
        
        return Checklist(
            id: entity.id ?? UUID(),
            name: entity.name ?? "Untitled",
            emoji: entity.emoji,   
            items: itemsArray
        )
    }
}


