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
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text("TEST")
                Text(item.name ?? " ")
                Text((item.brand ?? "") + " " + (item.model ?? ""))
                Text(String(item.weight)+" oz.")
                Text(String(item.qty))
                Spacer()
            }.padding()
            Spacer()
        }
    }
}

//#Preview {
//    ItemDetail()
//}
