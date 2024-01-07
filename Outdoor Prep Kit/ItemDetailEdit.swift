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
    @State var name = ""
    @State var brand = ""
    @State var model = ""
    @State var weight = 0.0
    @State var qty = 1
    @State var category = ""
    
    var body: some View {
        HStack{
            VStack{
                Form {
                    Section(header: Text("Item Name")) {
                        TextField("Name", text: $name)
                    }

                    Section(header: Text("Item Details")) {
                        TextField("Brand", text: $brand)
                        TextField("Model", text: $model)
                        TextField("Weight", value: $weight, formatter: {
                            let formatter = NumberFormatter()
                            formatter.numberStyle = .decimal
                            formatter.minimumFractionDigits = 1
                            formatter.maximumFractionDigits = 2
                            return formatter
                        }())
                        .keyboardType(.decimalPad)

                        Stepper(value: $qty, in: 1...100) {
                            Text("Quantity: \(qty)")
                        }
                        TextField("Category", text: $category)
                    }
                }
            }
        }
        .onAppear{
            name = item.name ?? ""
            brand = item.brand ?? ""
            model = item.model ?? ""
            weight = item.weight
            qty = Int(item.qty)
            category = item.category ?? ""
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
        item.name = name
        item.brand = brand
        item.model = model
        item.weight = weight
        item.qty = Int16(qty)
        item.category = category
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Failed to save Core Data changes: \(nsError)")
        }
    }
}

