import SwiftUI

struct ChecklistView: View {
    @Environment(\.managedObjectContext) private var context
    @StateObject private var viewModel: ChecklistViewModel
    @State private var showingAddItem = false
    
    init() {
        let context = PersistenceController.shared.container.viewContext
        _viewModel = StateObject(wrappedValue: ChecklistViewModel(context: context))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items) { item in
                    ChecklistRowView(item: item) {
                        viewModel.toggleItem(item)
                    }
                }
                .onDelete(perform: viewModel.deleteItem)
            }
            .navigationTitle("My Checklist")
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
