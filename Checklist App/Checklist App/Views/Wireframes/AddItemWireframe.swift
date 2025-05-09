//
//  AddItemWireframe.swift
//  Checklist App
//
//  Created by hugo gomez on 5/8/25.
//

import SwiftUI

struct AddItemWireframe: View {
    @State private var text = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("New Item").font(.headline)) {
                    TextField("Enter item", text: $text)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 8)
                }
                
                Section {
                    Button(action: {}) {
                        HStack {
                            Spacer()
                            Text("Add Item")
                                .fontWeight(.bold)
                            Spacer()
                        }
                    }
                    .disabled(text.isEmpty)
                    .padding()
                    .background(text.isEmpty ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
            .navigationTitle("Add New Item")
            .navigationBarItems(leading: Button("Cancel") {})
        }
    }
}

struct AddItemWireframe_Previews: PreviewProvider {
    static var previews: some View {
        AddItemWireframe()
    }
}
