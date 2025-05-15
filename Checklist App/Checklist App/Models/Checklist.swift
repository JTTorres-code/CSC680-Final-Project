//
//  Checklist.swift
//  Checklist App
//
//  Created by Jacob Torres on 5/12/25.
// It wasnt popping up into my commits so I had to manually change it this way 

import Foundation
import CoreData

struct Checklist: Identifiable, Codable {
    let id: UUID
    var name: String
    var emoji: String?
    var items: [ChecklistItem]
    var progress: ProgressInfo?
    
    struct ProgressInfo: Codable {
            var completed: Int
            var total: Int
            var percentage: Double
            
            init(completed: Int = 0, total: Int = 0) {
                self.completed = completed
                self.total = total
                self.percentage = total > 0 ? Double(completed) / Double(total) : 0
            }
        }


    init(id: UUID = UUID(), name: String, emoji: String? = nil, items: [ChecklistItem] = [], progress: ProgressInfo? = nil) {
            self.id = id
            self.name = name
            self.emoji = emoji
            self.items = items
            self.progress = progress ?? ProgressInfo(
                    completed: items.filter { $0.isCompleted }.count,
                    total: items.count)
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
            
            let completedCount = itemsArray.filter { $0.isCompleted }.count
            let totalCount = itemsArray.count
            
            return Checklist(
                id: entity.id ?? UUID(),
                name: entity.name ?? "Untitled",
                emoji: entity.emoji,
                items: itemsArray,
                progress: ProgressInfo(
                    completed: completedCount,
                    total: totalCount
                )
            )
        }
    }



