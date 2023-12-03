//
//  ItemCard.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/29/23.
//

import SwiftUI

struct ItemCard: View {
    @ObservedObject var item: Item
    
    @State private var isPacked: Bool
    init(item: Item) {
        self.item = item
        _isPacked = State(initialValue: item.packed)
    }
    
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
            Image(systemName: isPacked ? "backpack.circle" : "circle")
                .font(.system(size: 64))
                .foregroundColor(isPacked ? .green : .gray)
                .onTapGesture {
                    togglePacked()
                }
            .padding(.trailing)
        }
    }
    private func togglePacked() {
        withAnimation {
            item.packed.toggle()
            isPacked = item.packed
            saveContext()
        }
    }

    private func saveContext() {
        do {
            try item.managedObjectContext?.save()
        } catch {
            let nsError = error as NSError
            fatalError("Failed to save Core Data changes: \(nsError)")
        }
    }
}

