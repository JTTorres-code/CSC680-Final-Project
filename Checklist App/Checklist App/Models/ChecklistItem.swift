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
    
    init(id: UUID = UUID(), title: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}

extension ChecklistItem {
    func toManagedObject(context: NSManagedObjectContext) -> CDChecklistItem {
        let newItem = CDChecklistItem(context: context)
        newItem.id = self.id
        newItem.title = self.title
        newItem.isCompleted = self.isCompleted
        return newItem
    }
    
    static func fromManagedObject(_ item: CDChecklistItem) -> ChecklistItem {
        ChecklistItem(
            id: item.id ?? UUID(),
            title: item.title ?? "",
            isCompleted: item.isCompleted
        )
    }
}
