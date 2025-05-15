//
//  EditItemView.swift
//  Checklist App
//
//  Created by hugo gomez on 5/13/25.
//
import SwiftUI

struct EditItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ChecklistViewModel
    @State private var title: String
    @State private var dueDate: Date?
    @State private var showDatePicker: Bool = false
    @State private var tempSelectedDate: Date = Date()
    
    let item: ChecklistItem
    
    init(item: ChecklistItem, viewModel: ChecklistViewModel) {
        self.item = item
        self.viewModel = viewModel
        _title = State(initialValue: item.title)
        _dueDate = State(initialValue: item.dueDate)
        if let existingDate = item.dueDate {
            _tempSelectedDate = State(initialValue: existingDate)
        }
    }
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            NavigationView {
                Form {
                    Section(header: Text("Edit Item")) {
                        TextField("Enter item title", text: $title)
                        HStack {
                            Text("Due Date")
                            Spacer()
                            
                            if let dueDate = dueDate {
                                HStack {
                                    Text(dueDate.formatted(date: .abbreviated, time: .omitted))
                                    Button(action: {
                                        self.dueDate = nil
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.gray)
                                    }
                                }
                            } else {
                                Button(action: {
                                    tempSelectedDate = Date()
                                    showDatePicker = true
                                }) {
                                    Text("Add Due Date")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                        if showDatePicker {
                            VStack {
                                DatePicker(
                                    "Select Date",
                                    selection: $tempSelectedDate,
                                    displayedComponents: .date
                                )
                                .datePickerStyle(.graphical)
                                
                                Button("Done") {
                                    dueDate = tempSelectedDate
                                    showDatePicker = false
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .bold()
                                .padding(.top)
                            }
                        }
                    }
                    
                    Section {
                        Button(action: saveChanges) {
                            HStack {
                                Spacer()
                                Text("Save Changes")
                                Spacer()
                            }
                        }
                        .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                        .padding()
                        .background(title.trimmingCharacters(in: .whitespaces).isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                .navigationTitle("Edit Item")
                .scrollContentBackground(.hidden)
                .navigationBarItems(trailing: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                })
            }
        }
    }
    
    private func saveChanges() {
        if !title.trimmingCharacters(in: .whitespaces).isEmpty {
            viewModel.updateItem(
                item,
                newTitle: title,
                newDueDate: dueDate
            )
            presentationMode.wrappedValue.dismiss()
        }
    }
}
