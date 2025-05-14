// Modified by Ting Feng on 5/12/25

import SwiftUI

struct ChecklistView: View {
    let checklist: Checklist
    @StateObject var viewModel: ChecklistViewModel
    @State private var showingAddItem = false
    
    var body: some View {
        ZStack{
            Color("Background")
                .ignoresSafeArea()
            List {
                ForEach(viewModel.items) { item in
                    ChecklistRowView(item: item) {
                        viewModel.toggleItem(item)
                    }
                }
                .onDelete(perform: viewModel.deleteItem)
            }
            .scrollContentBackground(.hidden) 
            .background(Color("Background"))
            .environmentObject(viewModel)
            .navigationTitle(checklist.name)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddItem = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddItem) {
                AddItemView(viewModel: viewModel)
            }
        }
    }
    
}
