//
//  ItemListView.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/28/23.
//

import SwiftUI

struct ItemListView: View {
    var trip : Trip
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var items: [Item] = []
    
    var body: some View {
        NavigationView {
            List{
                ForEach(items) { item in
                    Text("Test")
                }
            }
        }
        .onAppear {
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
}

//#Preview {
//    ItemListView()
//}
