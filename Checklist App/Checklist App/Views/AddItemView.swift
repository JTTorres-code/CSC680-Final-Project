
//  AddItemView.swift
//  Checklist App
// Modified this a lil bit
//  Created by hugo gomez on 5/8/25.
//  Modified by Ting Feng on 5/12/25

import SwiftUI

struct AddItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ChecklistViewModel
    @State private var title: String = ""
    @State private var dueDate: Date? = nil
    @State private var showDatePicker: Bool = false
    @State private var tempSelectedDate: Date = Date()
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            NavigationView {
                Form {
                    Section(header: Text("New Item")) {
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
                        Button(action: addItem) {
                            HStack {
                                Spacer()
                                Text("Add Item")
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
                .navigationTitle("Add Item")
                .scrollContentBackground(.hidden)
                .navigationBarItems(trailing: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                })
            }
        }
    }
    
    private func addItem() {
        if !title.trimmingCharacters(in: .whitespaces).isEmpty {
            viewModel.addItem(title: title, dueDate: dueDate)
            presentationMode.wrappedValue.dismiss()
        }
    }
}
