//
//  ItemDetail.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/30/23.
//

import SwiftUI

struct ItemDetail: View {
    let item : Item
    @Binding var isViewingItemDetail : Bool
    
    @State private var isEditing = false
    
    var body: some View {
        if (!isEditing){
            ItemDetailDisplay(item: item, isViewingItemDetail: $isViewingItemDetail, isEditing: $isEditing)
        }else{
            ItemDetailEdit(item: item, isViewingItemDetail: $isViewingItemDetail, isEditing: $isEditing)
        }
    }
}

//#Preview {
//    ItemDetail()
//}
