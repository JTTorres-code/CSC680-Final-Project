//didnt add to my commits so im doing to manually
//  ChecklistListView.swift
//  Checklist App
//
//  Created by Jacob Torres on 5/12/25.
//  Modified by Ting Feng on 5/12/25
//  Modified by hugo gomez on 5/14/25

import SwiftUI
import CoreData

struct ChecklistListView: View {
    @Environment(\.managedObjectContext) private var context
    @StateObject private var managerVM: ChecklistManagerViewModel
    @State private var refreshID = UUID()

    @State private var showingAddChecklist = false
    @State private var newChecklistName = ""
    @State private var newChecklistEmoji = "📝"
    @State private var showingEmojiPicker = false
    @State private var showingHelp = false
    
    @State private var selectedChecklist: Checklist?
    @State private var editingName = ""
    @State private var editingEmoji = "📝"
    @State private var showingEditModal = false

    init(context: NSManagedObjectContext) {
        _managerVM = StateObject(wrappedValue: ChecklistManagerViewModel(context: context))
    }

    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(managerVM.checklists) { checklist in
                        HStack {
                            NavigationLink(
                                destination: ChecklistView(
                                    checklist: checklist,
                                    viewModel: ChecklistViewModel(context: context, checklistID: checklist.id)
                                )
                            ) {
                                HStack {
                                    Text(checklist.emoji ?? "📝")
                                        .font(.largeTitle)
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(checklist.name)
                                            .font(.headline)
                                        
                                        if let progress = checklist.progress, progress.total > 0 {
                                            HStack(spacing: 8) {
                                                ProgressView(value: progress.percentage)
                                                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                                                    .frame(width: 60)
                                                
                                                Text("\(progress.completed)/\(progress.total)")
                                                    .font(.caption)
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                    }
                                }
                            }
                            .buttonStyle(PlainButtonStyle())

                            Spacer()

                            Button(action: {
                                selectedChecklist = checklist
                                editingName = checklist.name
                                editingEmoji = checklist.emoji ?? "📝"
                                showingEditModal.toggle()
                            }) {
                                Image(systemName: "pencil")
                                    .foregroundColor(.blue)
                                    .imageScale(.medium)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                    .onDelete(perform: managerVM.deleteChecklist)
                }
                .background(Color("Background"))
                .scrollContentBackground(.hidden)
                .navigationTitle("My Checklists")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { showingHelp.toggle() }) {
                            Image(systemName: "questionmark.circle")
                                .font(.title3)
                        }
                    }
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

                            Section(header: Text("Choose Emoji")) {
                                Button(action: {
                                    showingEmojiPicker.toggle()
                                }) {
                                    Text("Pick Emoji: \(newChecklistEmoji)")
                                        .foregroundColor(.blue)
                                }
                                .popover(isPresented: $showingEmojiPicker) {
                                    EmojiPickerView(selectedEmoji: $newChecklistEmoji) {
                                        showingEmojiPicker = false
                                    }
                                    .frame(width: 300, height: 300)
                                }
                            }
                        }
                        .navigationTitle("New Checklist")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    showingAddChecklist = false
                                    newChecklistName = ""
                                    newChecklistEmoji = "📝"
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Add") {
                                    managerVM.addChecklist(
                                        name: newChecklistName,
                                        emoji: newChecklistEmoji.isEmpty ? "📝" : newChecklistEmoji
                                    )
                                    showingAddChecklist = false
                                    newChecklistName = ""
                                    newChecklistEmoji = "📝"
                                }
                                .disabled(newChecklistName.trimmingCharacters(in: .whitespaces).isEmpty)
                            }
                        }
                    }
                }
                .sheet(isPresented: $showingEditModal) {
                    NavigationView {
                        Form {
                            Section(header: Text("Edit Checklist Name")) {
                                TextField("Enter new name", text: $editingName)
                            }

                            Section(header: Text("Choose Emoji")) {
                                Button(action: {
                                    showingEmojiPicker.toggle()
                                }) {
                                    Text("Pick Emoji: \(editingEmoji)")
                                        .foregroundColor(.blue)
                                }
                                .popover(isPresented: $showingEmojiPicker) {
                                    EmojiPickerView(selectedEmoji: $editingEmoji) {
                                        showingEmojiPicker = false
                                    }
                                    .frame(width: 300, height: 300)
                                }
                            }
                        }
                        .navigationTitle("Edit Checklist")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    showingEditModal = false
                                    editingName = ""
                                    editingEmoji = "📝"
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Save Changes") {
                                    if let checklistToUpdate = selectedChecklist {
                                        managerVM.updateChecklistNameAndEmoji(
                                            for: checklistToUpdate.id,
                                            newName: editingName,
                                            newEmoji: editingEmoji
                                        )
                                    }
                                    showingEditModal = false
                                    editingName = ""
                                    editingEmoji = "📝"
                                }
                                .disabled(editingName.trimmingCharacters(in: .whitespaces).isEmpty)
                            }
                        }
                    }
                }
                .sheet(isPresented: $showingHelp) {
                    HelpView()
                }
            }
        }
    }
}
