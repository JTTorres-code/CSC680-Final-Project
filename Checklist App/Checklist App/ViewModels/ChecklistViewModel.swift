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
    
    init(context: NSManagedObjectContext) {
        self.context = context
        loadItems()
    }
    
    func addItem(title: String) {
        let newItem = ChecklistItem(title: title)
        _ = newItem.toManagedObject(context: context)
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
    
    private func loadItems() {
        let request: NSFetchRequest<CDChecklistItem> = CDChecklistItem.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CDChecklistItem.title, ascending: true)]
        
        do {
            let results = try context.fetch(request)
            items = results.map { ChecklistItem.fromManagedObject($0) }
        } catch {
            print("Error loading items: \(error)")
        }
    }
}
