//
//  AddItemView.swift
//  Checklist App
//
//  Created by hugo gomez on 5/8/25.
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ChecklistViewModel
    @State private var title: String = ""
    @State private var dueDate: Date = Date() // ➕ New state for due date

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("New Item")) {
                    TextField("Enter item title", text: $title)
                    
                    // ➕ DatePicker for selecting due date
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                }
                
                Section {
                    Button("Add Item") {
                        if !title.trimmingCharacters(in: .whitespaces).isEmpty {
                            viewModel.addItem(title: title, dueDate: dueDate) // 🛠️ Pass dueDate
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .navigationTitle("Add Item")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

