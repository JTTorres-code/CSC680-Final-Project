//
//  ChecklistViewModel.swift
//  Checklist App
//
//  Created by hugo gomez on 5/8/25.
//

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
    func addItem(title: String, dueDate: Date? = nil) {
        let checklistRequest: NSFetchRequest<CDChecklist> = CDChecklist.fetchRequest()
        checklistRequest.predicate = NSPredicate(format: "id == %@", checklistID as CVarArg)

        guard let checklistEntity = try? context.fetch(checklistRequest).first else {
            print("Checklist not found for ID: \(checklistID)")
            return
        }

        let newItem = ChecklistItem(title: title, dueDate: dueDate)

        let itemEntity = newItem.toManagedObject(context: context)
        itemEntity.checklist = checklistEntity

        saveContext()
    }

    func toggleItem(_ item: ChecklistItem) {
        let request: NSFetchRequest<CDChecklistItem> = CDChecklistItem.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", item.id as CVarArg)

        do {
            if let managedItem = try context.fetch(request).first {
                managedItem.isCompleted.toggle()
                saveContext()
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
    }

    private func saveContext() {
        do {
            try context.save()
            loadItems()
        } catch {
            print("Error saving context: \(error)")
        }
    }

    // ✅ Load only items for the current checklist
    private func loadItems() {
        let request: NSFetchRequest<CDChecklistItem> = CDChecklistItem.fetchRequest()
        request.predicate = NSPredicate(format: "checklist.id == %@", checklistID as CVarArg)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CDChecklistItem.title, ascending: true)]

        do {
            let results = try context.fetch(request)
            items = results.map { ChecklistItem.fromManagedObject($0) }
        } catch {
            print("Error loading items: \(error)")
        }
    }
}


