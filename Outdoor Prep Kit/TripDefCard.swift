//
//  TripDefCard.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 1/6/24.
//

import SwiftUI

struct TripDefCard: View {
    @Binding var trip : TripDef
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(trip.name)
            Text(trip.description)
        }
    }
}
