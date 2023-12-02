//
//  TripDetail.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/26/23.
//

import SwiftUI

struct TripDetail: View {
    var trip: Trip
    
    @State private var isAddingItem = false
    @State private var selectedItem: Item? = nil
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading){
                    Text(trip.name ?? "Test").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    Text(trip.descriptionText ?? "Test").font(.caption)
                }
                .padding()
                Spacer()
            }
            Spacer()
            HStack{
                Text("Items").font(.headline)
                Spacer()
                Button(action: {
                    isAddingItem = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .padding()
            ItemListView(trip: trip, isAddingItem: $isAddingItem)
        }
        .sheet(isPresented: $isAddingItem) {
            NavigationStack {
                AddItemView(trip: trip)
            }
        }
    }
}

//#Preview {
//    TripDetail()
//}
