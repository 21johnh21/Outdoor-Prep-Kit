//
//  TripEdit.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 12/5/23.
//

import SwiftUI

struct TripEdit: View {
    var trip: Trip
    @Binding var isEditing : Bool 
    @Binding var isAddingItem : Bool
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    @State private var name = ""
    @State private var descriptionText = ""
    
    var body: some View {
        Form{
            Section(header: Text("Outing Name")) {
                Group {
                    TextField("Enter name here…", text: $name)
                }
            }
            
            Section(header: Text("Trip Description")) {
                Group {
                    TextField("Enter description here…", text: $descriptionText)
                }
            }
        }
        .navigationTitle("Edit Trip")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Dismiss") {
                    isEditing = false
                }
            }
            ToolbarItem(placement: .primaryAction) {
                Button("Save") {
                    saveContext()
                    isEditing = false
                }
                .disabled(name.isEmpty || descriptionText.isEmpty)
            }
        }
        .onAppear{
            name = trip.name ?? ""
            descriptionText = trip.descriptionText ?? ""
        }
        ItemListView(trip: trip, isAddingItem: $isAddingItem)
    }
    private func saveContext() {
        trip.name = name
        trip.descriptionText = descriptionText
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Failed to save Core Data changes: \(nsError)")
        }
    }
}
