//
//  ItemListView.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/28/23.
//

import SwiftUI

struct ItemListView: View {
    var trip : Trip
    @Binding var isAddingItem: Bool
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var items: [Item] = []
    @State private var isViewingItemDetail = false
    @State private var selectedItem: Item? = nil
    
    var body: some View {
        NavigationView {
            List{
                ForEach(items) { item in
                    ItemCard(item: item)
                        .onTapGesture {
                            selectedItem = item
                            print("\(selectedItem?.name)")
                            isViewingItemDetail = true
                        }
                }
                .onDelete(perform: deleteItem)
            }
        }
        .sheet(isPresented: $isViewingItemDetail) {
            if let selectedItem = selectedItem {
                NavigationStack {
                    ItemDetail(item: selectedItem, isViewingItemDetail: $isViewingItemDetail)
                }
            }else{
                
            }
        }
        .onAppear {
            fetchItems()
            selectedItem = items.first
        }
        .onChange(of: isAddingItem){
            fetchItems()
        }
    }
    
    private func fetchItems() {
        // Check if the relationship 'items' is not nil
        if let itemsSet = trip.items {
            // Convert the NSSet to an array
            items = (itemsSet.allObjects as? [Item]) ?? []
        }
    }
    
    private func deleteItem(offsets: IndexSet) {
        withAnimation {
            // Get the items to be deleted based on the selected offsets
            let itemsToDelete = offsets.map { items[$0] }
            
            // Delete each item
            itemsToDelete.forEach { item in
                viewContext.delete(item)
            }

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

//#Preview {
//    ItemListView()
//}
