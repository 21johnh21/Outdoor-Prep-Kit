//
//  ItemDetailEdit.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 12/2/23.
//

import SwiftUI
import Combine

struct ItemDetailEdit: View {
    var item : Item
    @Binding var isEditing : Bool
    
    @Environment(\.managedObjectContext) private var viewContext
    @State var weightText = ""
    
    var body: some View {
        HStack{
            VStack{
                Form {
                    Section(header: Text("Item Name")) {
                        TextField("Name", text: Binding(
                            get: { item.name ?? "" },
                            set: { item.name = $0 }
                        ))
                    }

                    Section(header: Text("Item Details")) {
                        TextField("Brand", text: Binding(
                            get: { item.brand ?? "" },
                            set: { item.brand = $0 }
                        ))
                        TextField("Model", text: Binding(
                            get: { item.model ?? "" },
                            set: { item.model = $0 }
                        ))
                        TextField("Weight", value: Binding(
                            get: { item.weight },
                            set: { item.weight = $0 }
                        ), formatter: {
                            let formatter = NumberFormatter()
                            formatter.numberStyle = .decimal
                            formatter.minimumFractionDigits = 1
                            formatter.maximumFractionDigits = 2
                            return formatter
                        }())
                        .keyboardType(.decimalPad)

                        Stepper(value: Binding(
                            get: { item.qty },
                            set: { item.qty = $0 }
                        ), in: 1...100) {
                            Text("Quantity: \(item.qty)")
                        }
                    }
                }
            }
        }
        .navigationTitle("Edit Item")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Save") {
                    isEditing = false
                    saveContext()
                }
            }
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

