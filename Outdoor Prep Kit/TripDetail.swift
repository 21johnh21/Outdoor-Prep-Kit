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
    @State private var isEditing = false
    
    var body: some View {
        if (isEditing){
            TripEdit(trip: trip, isEditing: $isEditing, isAddingItem: $isAddingItem)
                .sheet(isPresented: $isAddingItem) {
                    NavigationStack {
                        AddItemView(trip: trip)
                    }
                }
        }else{
            VStack {
                HStack {
                    VStack(alignment: .leading){
                        Text(trip.name ?? "Test").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        Text(trip.descriptionText ?? "Test").font(.caption)
                    }
                    .padding([.leading, .trailing])
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
                .padding([.leading, .bottom, .trailing])
                ItemListView(trip: trip, isAddingItem: $isAddingItem)
            }
            .sheet(isPresented: $isAddingItem) {
                NavigationStack {
                    AddItemView(trip: trip)
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Edit") {
                        isEditing = true
                    }
                }
            }
        }
    }
}
