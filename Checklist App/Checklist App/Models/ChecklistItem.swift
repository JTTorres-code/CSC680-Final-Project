//
//  ChecklistItem.swift
//  Checklist App
//
//  Created by hugo gomez on 5/8/25.
//

import Foundation
import CoreData

struct ChecklistItem: Identifiable, Codable {
    let id: UUID
    var title: String
    var isCompleted: Bool
    var dueDate: Date?
    
    init(id: UUID = UUID(), title: String, isCompleted: Bool = false, dueDate: Date? = nil) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.dueDate = dueDate
    }

}


//added a bigger break to allow for better readability
extension ChecklistItem {
    func toManagedObject(context: NSManagedObjectContext) -> CDChecklistItem {
        let newItem = CDChecklistItem(context: context)
        newItem.id = self.id
        newItem.title = self.title
        newItem.isCompleted = self.isCompleted
        newItem.dueDate = self.dueDate
        return newItem
    }
    
    static func fromManagedObject(_ managedItem: CDChecklistItem) -> ChecklistItem {
        ChecklistItem(
            id: managedItem.id ?? UUID(),
            title: managedItem.title ?? "",
            isCompleted: managedItem.isCompleted,
            dueDate: managedItem.dueDate
        )
    }
}
