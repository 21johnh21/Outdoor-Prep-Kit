//
//  ItemCard.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/29/23.
//

import SwiftUI

struct ItemCard: View {
    let item: Item
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(item.name ?? "").font(.title3)
                HStack{
                    Text((item.brand ?? "") + " " + (item.model ?? "")).font(.caption)
                }
                HStack{
                    Text(String(item.weight)+"  oz.").font(.caption)
                    Spacer()
                    Text(String(item.qty)).font(.caption)
                }
            }
            .padding()
            Spacer()
            Image(systemName: "backpack.circle")
                .font(.system(size: 64))
                .padding(.trailing)
                .foregroundColor(.green)
        }
    }
}

