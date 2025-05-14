//
//  EmojiPickerView.swift
//  Checklist App
//
//  Created by hugo gomez on 5/13/25.
//

import SwiftUI

struct EmojiPickerView: View {
    @Binding var selectedEmoji: String
    var dismiss: () -> Void

    let emojis = [
        "📝", "✅", "❌", "🎯", "📋", "📚", "💼", "🧳", "🏡", "🛒", "🧹", "🧼", "🛠", "⚙️", "💡", "🚶‍♀️", "🏃‍♂️", "🌱", "🎉", "🛏",
        "🍎", "🍕", "🍔", "🛍", "📱", "📅", "🗂", "📇", "📚", "💻", "🎧", "📺", "🚗", "🚲", "🏠", "🏖", "📦", "🔧", "🖥", "💡", "📦",
        "⚡️", "🔋", "🛠", "🎯", "🔨", "💪", "🏅", "🎽", "💡", "🧳", "🚪", "🔑", "🔒", "🔓", "💬", "🧑‍🤝‍🧑", "📜", "🌎", "🌍", "🌏",
        "🔖", "🧸", "🎲", "🎯", "🗂", "📏", "🎧", "🎵", "🎶", "🎼", "🎹", "🎤", "📷", "🎬", "🎮", "🧩", "🧶", "🧶", "📉", "📝", "🎱",
        "🧪", "🔬", "⚙️", "🗑", "🖋", "🖊", "🎮", "🎧", "📞", "💻", "🖥", "🎮", "🖨", "📱", "📠", "🚴‍♂️", "🚶‍♀️", "🚗", "🚲", "🎁",
        "🎊", "🎈", "🛣", "🗺", "🏆", "🏅", "⏰", "🔦", "📢", "📣", "⚠️", "⚡", "🌈", "💭", "📝", "📌", "🎯", "🛒", "💳", "💼", "📆", "📚"
    ]

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("⬇️ Scroll to see more emojis")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.top, 10)
                    .opacity(0.8)
                Spacer()
            }
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
                    ForEach(Array(emojis.enumerated()), id: \.offset) { index, emoji in
                        Button(action: {
                            selectedEmoji = emoji
                            dismiss()
                        }) {
                            Text(emoji)
                                .font(.largeTitle)
                                .padding()
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .navigationTitle("Select Emoji")
        }
    }
}
