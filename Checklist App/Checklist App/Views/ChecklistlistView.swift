//
//  ChecklistListView.swift
//  Checklist App
//
//  Created by Jacob Torres on 5/12/25.
//  Modified by Ting Feng on 5/12/25

import SwiftUI
import CoreData

struct ChecklistListView: View {
    @Environment(\.managedObjectContext) private var context
    @StateObject private var managerVM: ChecklistManagerViewModel
    
    @State private var showingAddChecklist = false
    @State private var newChecklistName = ""
    
    init(context: NSManagedObjectContext) {
        _managerVM = StateObject(wrappedValue: ChecklistManagerViewModel(context: context))
    }
    
    var body: some View {
        ZStack{
            NavigationView {
                List {
                    ForEach(managerVM.checklists) { checklist in
                        NavigationLink(
                            destination: ChecklistView(
                                checklist: checklist,
                                viewModel: ChecklistViewModel(context: context, checklistID: checklist.id)
                            )
                        ) {
                            Text(checklist.name)
                                .font(.headline)
                        }
                        .listRowBackground(Color("Background"))
                    }
                    .onDelete(perform: managerVM.deleteChecklist)
                }
                .background(Color("Background"))
                .scrollContentBackground(.hidden)
                .navigationTitle("My Checklists")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showingAddChecklist = true }) {
                            Label("Add Checklist", systemImage: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showingAddChecklist) {
                    NavigationView {
                        Form {
                            Section(header: Text("Checklist Name")) {
                                TextField("Like Groceries", text: $newChecklistName)
                            }
                        }
                        .navigationTitle("New Checklist")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    showingAddChecklist = false
                                    newChecklistName = ""
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Add") {
                                    managerVM.addChecklist(name: newChecklistName)
                                    showingAddChecklist = false
                                    newChecklistName = ""
                                }
                                .disabled(newChecklistName.trimmingCharacters(in: .whitespaces).isEmpty)
                            }
                        }
                    }
                }
            }
        }
    }
}
    

