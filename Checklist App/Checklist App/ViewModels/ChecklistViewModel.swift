//Modified this one too
//  ChecklistViewModel.swift
//  Checklist App
//
//  Created by hugo gomez on 5/8/25.
//  Modified by Ting Feng on 5/12/25

import Foundation
import CoreData

class ChecklistViewModel: ObservableObject {
    @Published var items: [ChecklistItem] = []
    private let context: NSManagedObjectContext
    private let checklistID: UUID
    
    // ✅ Pass checklist ID into the initializer
    init(context: NSManagedObjectContext, checklistID: UUID) {
        self.context = context
        self.checklistID = checklistID
        loadItems()
    }
    
    // ✅ Add item and link it to the correct checklist
    func addItem(title: String, dueDate: Date? = nil, priority: Priority) {
        let checklistRequest: NSFetchRequest<CDChecklist> = CDChecklist.fetchRequest()
        checklistRequest.predicate = NSPredicate(format: "id == %@", checklistID as CVarArg)
        
        guard let checklistEntity = try? context.fetch(checklistRequest).first else {
            print("Checklist not found for ID: \(checklistID)")
            return
        }
        
        let newItem = ChecklistItem(title: title, dueDate: dueDate, priority: priority)
        
        let itemEntity = newItem.toManagedObject(context: context)
        itemEntity.checklist = checklistEntity
        
        saveContext()
        
        loadItems()
        
        NotificationCenter.default.post(
            name: Notification.Name("ChecklistItemToggled"),
            object: nil,
            userInfo: ["checklistID": checklistID]
        )
    }

    
    func toggleItem(_ item: ChecklistItem) {
        let request: NSFetchRequest<CDChecklistItem> = CDChecklistItem.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", item.id as CVarArg)
        
        do {
            if let managedItem = try context.fetch(request).first {
                managedItem.isCompleted.toggle()
                try context.save()
                
                NotificationCenter.default.post(
                    name: Notification.Name("ChecklistItemToggled"),
                    object: nil,
                    userInfo: ["checklistID": checklistID]
                )
                
                loadItems()
            }
        } catch {
            print("Error toggling item: \(error)")
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        offsets.map { items[$0] }.forEach { item in
            let request: NSFetchRequest<CDChecklistItem> = CDChecklistItem.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", item.id as CVarArg)
            
            do {
                if let managedItem = try context.fetch(request).first {
                    context.delete(managedItem)
                }
            } catch {
                print("Error deleting item: \(error)")
            }
        }
        saveContext()
        
        loadItems()
            
            NotificationCenter.default.post(
                name: Notification.Name("ChecklistItemToggled"),
                object: nil,
                userInfo: ["checklistID": checklistID]
            )
    }
    
    func updateItem(_ item: ChecklistItem, newTitle: String, newDueDate: Date?, newPriority: Priority) {
        let request: NSFetchRequest<CDChecklistItem> = CDChecklistItem.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", item.id as CVarArg)
        
        do {
            if let managedItem = try context.fetch(request).first {
                managedItem.title = newTitle
                managedItem.dueDate = newDueDate
                managedItem.priority = newPriority.rawValue
                saveContext()
            } else {
                print("Item with ID \(item.id) not found in Core Data")
            }
        } catch {
            print("Error updating item: \(error)")
        }
    }
    
    
    private func saveContext() {
        do {
            try context.save()
            loadItems()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    // ✅ Load only items for the current checklist, sort by due date
    private func loadItems() {
        let request: NSFetchRequest<CDChecklistItem> = CDChecklistItem.fetchRequest()
        request.predicate = NSPredicate(format: "checklist.id == %@", checklistID as CVarArg)
        
        // 🔽 Sort by dueDate (nil values will be last if ascending is true)
        let sortByDueDate = NSSortDescriptor(
                key: "dueDate",
                ascending: true,
                selector: #selector(NSDate.compare(_:))
            )
            request.sortDescriptors = [sortByDueDate]
            
            do {
                let results = try context.fetch(request)
                items = results
                    .map { ChecklistItem.fromManagedObject($0) }
                    .sorted {
                        switch ($0.dueDate, $1.dueDate) {
                        case (nil, nil): return false
                        case (nil, _): return false
                        case (_, nil): return true
                        case (let date1, let date2):
                            return date1! < date2!
                        }
                    }
            } catch {
                print("Error loading items: \(error)")
            }
        }
}


