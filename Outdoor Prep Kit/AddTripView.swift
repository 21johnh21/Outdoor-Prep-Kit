//
//  AddTripView.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/26/23.
//

import SwiftUI

struct AddTripView: View {
    
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
        .navigationTitle("Add Trip")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Dismiss") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .primaryAction) {
                Button("Done") {
                    addTrip()
                    dismiss()
                }
                .disabled(name.isEmpty || descriptionText.isEmpty)
            }
        }
    }
        
    private func addTrip() {
        withAnimation {
            let newTrip = Trip(context: viewContext)
            newTrip.name = name
            newTrip.descriptionText = descriptionText
            newTrip.timestamp = Date()
            saveContext()
        }
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

#Preview {
    AddTripView()
}
