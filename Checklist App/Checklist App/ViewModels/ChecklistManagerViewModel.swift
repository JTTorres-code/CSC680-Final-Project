//
//  ChecklistManagerViewModel.swift
//  Checklist App
//
//  Created by Jacob Torres on 5/12/25.
//

import Foundation
import CoreData

class ChecklistManagerViewModel: ObservableObject {
    @Published var checklists: [Checklist] = []
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        loadChecklists()
    }

    // Load all checklists from Core Data
    func loadChecklists() {
        let request: NSFetchRequest<CDChecklist> = CDChecklist.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CDChecklist.name, ascending: true)]

        do {
            let results = try context.fetch(request)
            checklists = results.map { Checklist.fromManagedObject($0) }
        } catch {
            print("Error loading checklists: \(error)")
        }
    }

    // Add a new checklist
    func addChecklist(name: String, emoji: String = "📝") {
        let newChecklist = Checklist(name: name, emoji: emoji)
        _ = newChecklist.toManagedObject(context: context)
        saveContext()
    }


    // Delete a checklist
    func deleteChecklist(at offsets: IndexSet) {
        offsets.map { checklists[$0] }.forEach { checklist in
            let request: NSFetchRequest<CDChecklist> = CDChecklist.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", checklist.id as CVarArg)

            do {
                if let match = try context.fetch(request).first {
                    context.delete(match)
                }
            } catch {
                print("Error deleting checklist: \(error)")
            }
        }
        saveContext()
    }
    
    func updateChecklistNameAndEmoji(for checklistID: UUID, newName: String, newEmoji: String) {
        let request: NSFetchRequest<CDChecklist> = CDChecklist.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", checklistID as CVarArg)

        do {
            if let checklistEntity = try context.fetch(request).first {
                checklistEntity.name = newName
                checklistEntity.emoji = newEmoji  
                saveContext()
            } else {
                print("Checklist not found for ID: \(checklistID)")
            }
        } catch {
            print("Error updating checklist name and emoji: \(error)")
        }
    }

    

    // Save context and reload checklists
    private func saveContext() {
        do {
            try context.save()
            loadChecklists()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}


