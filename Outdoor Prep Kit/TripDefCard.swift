//
//  TripDefCard.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 1/6/24.
//

import SwiftUI

struct TripDefCard: View {
    @Binding var trip : TripDef
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(trip.name)
            Text(trip.description)
        }
        .onTapGesture {
            SaveTrip()
        }
    }
    
    private func SaveTrip(){
        let newTrip = Trip(context: viewContext)
        newTrip.name = trip.name
        newTrip.descriptionText = trip.description
        newTrip.timestamp = Date()
        saveContext()
    }
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Failed to save Core Data changes: \(nsError)")
        }
    }
}
