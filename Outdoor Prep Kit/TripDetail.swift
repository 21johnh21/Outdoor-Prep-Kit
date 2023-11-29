//
//  TripDetail.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/26/23.
//

import SwiftUI

struct TripDetail: View {
    var trip: Trip
    
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
//                    showItemEdit = true
//                    isAddingNewItem = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .padding()
        }
    }
}

//#Preview {
//    TripDetail()
//}
