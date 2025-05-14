//
//  EditItemView.swift
//  Checklist App
//
//  Created by hugo gomez on 5/13/25.
//
import SwiftUI

struct EditItemView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: ChecklistViewModel
    @State private var editedTitle: String
    @State private var editedDueDate: Date?
    
    let item: ChecklistItem
    
    init(item: ChecklistItem) {
        self.item = item
        _editedTitle = State(initialValue: item.title)
        _editedDueDate = State(initialValue: item.dueDate)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Item title", text: $editedTitle)
                    
                    DatePicker("Due Date",
                              selection: Binding(
                                get: { editedDueDate ?? Date() },
                                set: { editedDueDate = $0 }
                              ),
                              displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    
                    Button("Remove Due Date") {
                        editedDueDate = nil
                    }
                    .foregroundColor(.red)
                    .disabled(editedDueDate == nil)
                }
                
                Section {
                    Button("Save Changes") {
                        viewModel.updateItem(
                            item,
                            newTitle: editedTitle,
                            newDueDate: editedDueDate
                        )
                        dismiss()
                    }
                    .disabled(editedTitle.isEmpty)
                }
            }
            .navigationTitle("Edit Item")
            .navigationBarItems(trailing: Button("Cancel") { dismiss() })
        }
    }
}
