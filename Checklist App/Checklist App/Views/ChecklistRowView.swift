//
//  ChecklistRowView.swift
//  Checklist App
//
//  Created by hugo gomez on 5/8/25.
//

import SwiftUI

struct ChecklistRowView: View {
    let item: ChecklistItem
    let action: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(item.isCompleted ? .green : .gray)
            Text(item.title)
                .strikethrough(item.isCompleted)
                .foregroundColor(item.isCompleted ? .gray : .primary)
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: action)
    }
}
