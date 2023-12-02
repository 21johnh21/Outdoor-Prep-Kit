//
//  ItemDetailEdit.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 12/2/23.
//

import SwiftUI

struct ItemDetailEdit: View {
    let item : Item
    @Binding var isViewingItemDetail : Bool
    @Binding var isEditing : Bool
    
    var body: some View {
        HStack{
            VStack{
                
            }
        }
        .navigationTitle("\(item.name ?? " ")")
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

