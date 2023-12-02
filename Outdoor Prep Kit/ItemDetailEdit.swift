//
//  ItemDetailEdit.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 12/2/23.
//

import SwiftUI
import Combine

struct ItemDetailEdit: View {
    @Binding var item : Item
    @Binding var isViewingItemDetail : Bool
    @Binding var isEditing : Bool
    
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
                        ), formatter: NumberFormatter())
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
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    isEditing = false
                }
            }
            ToolbarItem(placement: .primaryAction) {
                Button("Save") {
                    isEditing = false
                }
            }
        }
    }
}

