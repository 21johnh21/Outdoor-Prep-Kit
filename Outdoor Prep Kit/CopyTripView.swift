//
//  CopyTripView.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 1/6/24.
//

import SwiftUI

struct CopyTripView: View {
    
    @ObservedObject private var tripsManager = Trips() 
    
    var body: some View {
        List{
            ForEach($tripsManager.trips) { $trip in
                TripDefCard(trip: $trip)
            }
        }
    }
}

#Preview {
    CopyTripView()
}
