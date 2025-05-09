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
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("New Item")) {
                    TextField("Enter item title", text: $title)
                }
                
                Section {
                    Button("Add Item") {
                        if !title.trimmingCharacters(in: .whitespaces).isEmpty {
                            viewModel.addItem(title: title)
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
