//
//  Trips.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/18/23.
//

import Foundation

class Trips: ObservableObject{
    
    @Published var trips = [TripDef]()
    
    init(){
        load()
    }
    
    func save (trips: [TripDef]){
        
        //Don't save default trips
        let userCreatedTrips = trips.filter{$0.id.uuidString.hasPrefix("def")}
        let data = try? JSONEncoder().encode(userCreatedTrips)
        guard let outfile = try? Self.getFileURL() else { return }
        try? data?.write(to: outfile)
    }
    
    func load (){
        guard let fileURL = try? Self.getFileURL() else { 
            self.trips = loadDefaultTrips()
            return }
        guard let data = try? Data(contentsOf: fileURL) else { 
            self.trips = loadDefaultTrips()
            return }
        // for debuging -------
//        let loadedData = try? JSONDecoder().decode(Item.self, from: data)
//        print(loadedData)
        if true{
            if let json = String(data: data, encoding: .utf8) {
                print(json)
            }
        }
        // ----
        guard var trips = try? JSONDecoder().decode([TripDef].self, from: data) else {
            self.trips = loadDefaultTrips()
            return  }
        trips += loadDefaultTrips()
        self.trips = trips
    }
    
    func loadDefaultTrips()-> [TripDef] {
        if let fileLocation = Bundle.main.url(forResource: "defaultTrips", withExtension: "json"){
            do{
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let jsonData = try jsonDecoder.decode([TripDef].self, from: data)
                return jsonData
            }
            catch{
                print("Error: error decoding json")
            }
        }
        return []
    }
    
    private static func getFileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("trips.data")
    }

    //TODO: Eventually I'll want to load in defaults from a json file. Possibly stored in the cloud.
}

