//
//  HelpView.swift
//  Checklist App
//
//  Created by hugo gomez on 5/14/25.
//

import SwiftUI

struct HelpView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Checklist App Guide")
                        .font(.title)
                        .bold()
                        .padding(.bottom, 10)
                    
                    HelpSection(
                        title: "Creating Checklists",
                        content: "Tap the + button to create a new checklist. Give it a name and choose an emoji to represent it."
                    )
                    
                    HelpSection(
                        title: "Adding Items",
                        content: "Inside a checklist, tap the + to create new tasks. You can set due dates that automatically sort by earliest due date first. If a task does not have a due date, it will appear at the below the ones with due dates."
                    )
                    
                    HelpSection(
                        title: "Completing Tasks",
                        content: "Tap any item to mark it as completed. Your progress will be shown on each checklist."
                    )
                    
                    HelpSection(
                        title: "Editing",
                        content: "Tap the pencil icon to rename a checklist or change its emoji. You can also edit task also by pressing the pencil icon to change the name and due date or remove due dates. Swipe left to delete."
                    )
                    
                    HelpSection(
                        title: "Setting Priority",
                        content: "Set priority level for your tasks, low (green), medium (orange), high (red). This will help know which tasks need to been completed first. Once completed, the priority indicator will go away unless unchecked again."
                    )
                    
                    HelpSection(
                        title: "Dark/Light Mode",
                        content: "On your device if your appearance is set to Light or Dark Mode, the app will change its appearance as well"
                    )
                }
                .padding()
            }
            .navigationTitle("Help")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct HelpSection: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.blue)
            
            Text(content)
                .font(.body)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
