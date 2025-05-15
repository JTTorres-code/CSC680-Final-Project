//
//  AddChecklistWireframe.swift
//  Checklist App
//
//  Created by hugo gomez on 5/14/25.
//

import SwiftUI

struct AddChecklistWireframe: View {
    @State private var title = ""
    @State private var emoji = "📝"
    @State private var showingEmojiPicker = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Checklist Name").font(.headline)) {
                    TextField("Like Groceries", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 8)
                    
                    Section(header: Text("Choose Emoji").font(.headline)) {
                        HStack {
                            Text("Pick Emoji")
                            Spacer()
                            Button(action: {
                                showingEmojiPicker = true
                            }) {
                                Text(emoji)
                                    .font(.title)
                                    .padding(8)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(8)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
            .navigationTitle("New Checklist")
            .navigationBarItems(
                leading: Button("Cancel") {},
                trailing: Button("Add") {}
                    .disabled(title.isEmpty)
            )
            .sheet(isPresented: $showingEmojiPicker) {
                EmojiPickerWireframe(selectedEmoji: $emoji)
            }
        }
    }
}

struct EmojiPickerWireframe: View {
    @Binding var selectedEmoji: String
    let commonEmojis = ["📝", "🛒", "🏠", "💼", "🎯", "📚", "✈️", "🎮"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
                    ForEach(commonEmojis, id: \.self) { emoji in
                        Button(action: {
                            selectedEmoji = emoji
                        }) {
                            Text(emoji)
                                .font(.system(size: 40))
                                .padding()
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Choose Emoji")
            .navigationBarItems(trailing: Button("Done") {})
        }
    }
}

struct AddChecklistWireframe_Previews: PreviewProvider {
    static var previews: some View {
        AddChecklistWireframe()
    }
}
