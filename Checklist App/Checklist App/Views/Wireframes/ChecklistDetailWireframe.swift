//
//  ChecklistDetailWireframe.swift
//  Checklist App
//
//  Created by hugo gomez on 5/8/25.
//

import SwiftUI

struct ChecklistDetailWireframe: View {
    let sampleItems = [
        ("Milk", true),
        ("Eggs", false),
        ("Bread", true),
        ("Apples", false),
        ("Coffee", true)
    ]
    
    var body: some View {
        List {
            ForEach(0..<sampleItems.count, id: \.self) { index in
                HStack {
                    Image(systemName: sampleItems[index].1 ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(sampleItems[index].1 ? .green : .gray)
                    Text(sampleItems[index].0)
                        .strikethrough(sampleItems[index].1)
                }
            }
            .onDelete(perform: { _ in })
        }
        .navigationTitle("Groceries")
        .toolbar {
            Button(action: {}) {
                Image(systemName: "plus")
            }
        }
    }
}

struct ChecklistDetailWireframe_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChecklistDetailWireframe()
        }
    }
}
