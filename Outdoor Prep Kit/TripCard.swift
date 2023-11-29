//
//  TripCard.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/12/23.
//

import SwiftUI

struct TripCard: View {
    let trip : Trip
    
    var body: some View {
        VStack(alignment: .leading){
            Text(trip.name ?? "Test")
            Text(trip.descriptionText ?? "Test" )
        }
//        .swipeActions(edge: .leading) {
//            Button(action: {
//                editingTrip = trip
//                showTripEdit = true
//            }) {
//                Image(systemName: "pencil.circle.fill")
//            }
//        }
    }
}

//#Preview {
//    TripCard(trip: .constant(Trip.sampleTrips[0]), showTripEdit: .constant(true), editingTrip: .constant(Trip.sampleTrips[0]))
//}
