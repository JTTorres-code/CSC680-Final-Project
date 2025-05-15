// something didnt work and i had to adjust it again
//  ChecklistManagerViewModel.swift
//  Checklist App
//
//  Created by Jacob Torres on 5/12/25.
//messed with it

import Foundation
import CoreData
import Combine

class ChecklistManagerViewModel: ObservableObject {
    @Published var checklists: [Checklist] = []
    private let context: NSManagedObjectContext
    private var cancellables = Set<AnyCancellable>()

    init(context: NSManagedObjectContext) {
        self.context = context
        loadChecklists()
        
        NotificationCenter.default.publisher(for: Notification.Name("ChecklistItemToggled"))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.loadChecklists() 
            }
            .store(in: &cancellables)
    }

    // Load all checklists from Core Data
    func loadChecklists() {
            let request: NSFetchRequest<CDChecklist> = CDChecklist.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(keyPath: \CDChecklist.name, ascending: true)]
            request.relationshipKeyPathsForPrefetching = ["items"]

            do {
                let results = try context.fetch(request)
                checklists = results.map { cdChecklist in
                    var checklist = Checklist.fromManagedObject(cdChecklist)
                    checklist.progress = calculateProgress(for: cdChecklist)
                    return checklist
                }
            } catch {
                print("Error loading checklists: \(error)")
            }
        }
    
    // Calculate completion progress for a checklist
    private func calculateProgress(for cdChecklist: CDChecklist) -> Checklist.ProgressInfo {
        guard let items = cdChecklist.items?.allObjects as? [CDChecklistItem] else {
            return Checklist.ProgressInfo(completed: 0, total: 0)
        }
        
        let completedCount = items.filter { $0.isCompleted }.count
        return Checklist.ProgressInfo(completed: completedCount, total: items.count)
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
        if let index = checklists.firstIndex(where: { $0.id == checklistID }) {
            let request: NSFetchRequest<CDChecklist> = CDChecklist.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", checklistID as CVarArg)
            
            do {
                if let cdChecklist = try context.fetch(request).first {
                    checklists[index].progress = calculateProgress(for: cdChecklist)
                }
            } catch {
                print("Error updating progress: \(error)")
            }
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


