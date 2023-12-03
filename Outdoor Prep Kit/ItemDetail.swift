//
//  ItemDetail.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/30/23.
//

import SwiftUI

struct ItemDetail: View {
    var item : Item
    
    @State private var isEditing = false
    
    var body: some View {
        if (!isEditing){
            ItemDetailDisplay(item: item, isEditing: $isEditing)
        }else{
            ItemDetailEdit(item: item, isEditing: $isEditing)
        }
    }
}
