//
//  AddItemView.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/28/23.
//

import SwiftUI
import Combine

struct AddItemView: View {
    let trip : Trip
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    @State private var name = ""
    @State private var brand = ""
    @State private var model = ""
    @State private var weight = 0.0
    @State private var weightText = ""
    @State private var qty : Int = 1
    
    var body: some View {
        Form{
            Section(header: Text("Item Name")) {
                Group {
                    TextField("Name", text: $name)
                }
            }
            
            Section(header: Text("Item Details")) {
                Group {
                    TextField("Brand", text: $brand)
                    TextField("Model", text: $model)
                    TextField("weight", text: $weightText)
                        .keyboardType(.decimalPad)
                        .onReceive(Just(weightText)) { newValue in
                            weightText = newValue.filter { $0.isNumber || $0 == "." }
                            weight = Double(weightText) ?? 0
                        }
                    Stepper(value: $qty, in: 1...100) {
                        Text("\(qty)")
                    }
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
            newItem.weight = weight
            newItem.qty = Int16(qty)
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
