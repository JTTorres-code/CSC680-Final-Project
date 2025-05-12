//
//  Checklist_AppApp.swift
//  Checklist App
//
//  Created by hugo gomez on 5/8/25.
//

import SwiftUI
import CoreData

@main
struct Checklist_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ChecklistListView(context: persistenceController.container.viewContext)
                .environment(\EnvironmentValues.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "ChecklistModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("CoreData failed to load: \(error.localizedDescription)")
            }
        }
    }
}

