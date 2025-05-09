//
//  ChecklistWireframe.swift
//  Checklist App
//
//  Created by hugo gomez on 5/8/25.
//

import SwiftUI

struct ChecklistWireframe: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("My Checklists").font(.headline)) {
                    NavigationLink(destination: ChecklistDetailWireframe()) {
                        HStack {
                            Image(systemName: "list.bullet")
                                .foregroundColor(.blue)
                            Text("Groceries")
                            Spacer()
                            Text("5 items")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    NavigationLink(destination: ChecklistDetailWireframe()) {
                        HStack {
                            Image(systemName: "list.bullet")
                                .foregroundColor(.blue)
                            Text("Work Tasks")
                            Spacer()
                            Text("3 items")
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Checklist App")
            .toolbar {
                Button(action: {}) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct ChecklistWireframe_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChecklistWireframe()
                .previewDisplayName("Light Mode")
            
            ChecklistWireframe()
                .previewDisplayName("Dark Mode")
                .preferredColorScheme(.dark)
        }
    }
}
