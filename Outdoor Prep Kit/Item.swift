//
//  ItemDef.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/11/23.
//

import Foundation

struct ItemDef: Identifiable, Codable {
    let id : UUID
    var name : String
    var brand : String
    var model : String
    var weight : Double
    var qty : Int
    var category : String
    var tripIDs : [UUID]
    
    init(id: UUID=UUID(), name: String, brand: String, model: String, weight: Double, qty: Int, category: String, tripIDs: [UUID]) {
        self.id = id
        self.name = name
        self.brand = brand
        self.model = model
        self.weight = weight
        self.qty = qty
        self.category = category
        self.tripIDs = tripIDs
    }
    
    mutating func clear(){
        self.name=""
        self.brand=""
        self.model=""
        self.weight=0.0
        self.qty = 1
        self.category = "Shelter"
        self.tripIDs=[]
    }
}

extension ItemDef{
    static var categories = ["Shelter", "Sleep", "Cooking", "Clothing", "First Aid"]
}

extension ItemDef{
    static var sampleItems : [ItemDef] =
    [
        ItemDef(
            name: "Tent",
            brand: "Big Agnes",
            model: "Copper Spur",
            weight: 20.2,
            qty: 1,
            category: "Shelter",
            tripIDs:[]
        ),
        ItemDef(
            name: "Sleeping Bag",
            brand: "Big Agnes",
            model: "Sub Zero Bag",
            weight: 40.5,
            qty: 1,
            category: "Sleep",
            tripIDs:[]
        )
    ]
}
