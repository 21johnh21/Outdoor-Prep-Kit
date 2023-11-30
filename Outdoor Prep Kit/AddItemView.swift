//
//  AddItemView.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/28/23.
//

import SwiftUI

struct AddItemView: View {
    let trip : Trip
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    @State private var name = ""
    @State private var brand = ""
    @State private var model = ""
    
    var body: some View {
        Form{
            Section(header: Text("Outing Name")) {
                Group {
                    TextField("Enter name here…", text: $name)
                }
            }
            
            Section(header: Text("Trip Description")) {
                Group {
                    TextField("Enter description here…", text: $brand)
                    TextField("Enter description here…", text: $model)
                }
            }
        }
        .navigationTitle("Add Item")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Dismiss") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .primaryAction) {
                Button("Save") {
                    addItem()
                    dismiss()
                }
                .disabled(name.isEmpty)
            }
        }
    }
        
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.trip = trip
            newItem.name = name
            newItem.brand = brand
            newItem.model = model
            newItem.timestamp = Date()
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

//#Preview {
//    AddItemView()
//}
