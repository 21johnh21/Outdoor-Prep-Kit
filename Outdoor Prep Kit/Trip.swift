//
//  TripDef.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/12/23.
//

import Foundation

struct TripDef: Identifiable, Codable {
    let id : UUID
    var name : String
    var description : String
    
    init(id: UUID=UUID(), name: String, description: String) {
        self.id = id
        self.name = name
        self.description = description
    }
}

extension TripDef {
    static let sampleTrips: [TripDef] =
    [
        TripDef(
            name: "Hiking",
            description: "day hike with no over nigth supplies"
        ),
        TripDef(
            name: "Backpacking",
            description: "Multi day hik"
        ),
        TripDef(
            name: "Bushcrafting",
            description: "Multi day hike with an emphasis on living off the land"
        )
    ]
}

