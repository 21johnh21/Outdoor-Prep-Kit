//
//  ItemDetailDisplay.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 12/2/23.
//

import SwiftUI

struct ItemDetailDisplay: View {
    var item : Item
    @Binding var isEditing : Bool 
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text((item.brand ?? "") + " " + (item.model ?? ""))
                    Text(String(item.weight)+" oz.")
                    Text(String(item.qty))
                    Text(String(item.category ?? ""))
                    WebViewContainer(item: item)
                        .navigationBarTitle("Web Page", displayMode: .inline)
                    Spacer()
                }.padding()
                Spacer()
            }
            .navigationTitle("\(item.name ?? " ")")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Edit") {
                        isEditing = true
                    }
                }
            }
        }
    }
}

