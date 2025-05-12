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

            VStack(alignment: .leading) {
                Text(item.title)
                    .strikethrough(item.isCompleted)
                    .foregroundColor(item.isCompleted ? .gray : .primary)

                // ➕ Show due date if available
                if let dueDate = item.dueDate {
                    Text("Due: \(dueDate, formatter: dateFormatter)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: action)
    }

    // ➕ Formatter for due date
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}


