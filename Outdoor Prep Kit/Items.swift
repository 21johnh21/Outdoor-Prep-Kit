//
//  ItemDefs.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/18/23.
//

import Foundation

class Items: ObservableObject {
    var tripID: UUID?

    @Published var items = [ItemDef]()

    init(tripID: UUID?) {
        self.tripID = tripID
        load()
    }

    func save(items: [ItemDef]) {
        let userCreatedItems = items.filter{$0.id.uuidString.hasPrefix("def")}
        
        let data = try? JSONEncoder().encode(userCreatedItems)
        guard let outfile = try? Self.getFileURL(tripID: tripID) else { return }
        try? data?.write(to: outfile)
    }

    func load() {
        guard let fileURL = try? Self.getFileURL(tripID: tripID) else { return }
        guard let data = try? Data(contentsOf: fileURL) else { return }
//        
//        if true{
//            if let json = String(data: data, encoding: .utf8) {
//                print(json)
//            }
//        }
        
        guard var itemsFortrip = (try? JSONDecoder().decode([ItemDef].self, from: data)) else {
            self.items = filterItems(items: loadDefaultItems())
            return
        }
        
        itemsFortrip += loadDefaultItems()
        print("items: "+String(itemsFortrip.count))
        self.items = filterItems(items: itemsFortrip)
        
//        if let tripID = tripID {
//            let itemsForTrip = (try? JSONDecoder().decode([Item].self, from: data))?
//                .filter { $0.tripIDs.contains(tripID) } ?? []
//            self.items = itemsForTrip
//        } else {
//            let allItems = try? JSONDecoder().decode([Item].self, from: data)
//            self.items = allItems ?? []
//        }
    }
    
    func filterItems(items: [ItemDef]) -> [ItemDef] {
        if let tripID = tripID {
            return items.filter { $0.tripIDs.contains(tripID) }
        }
        
        return []
    }
    
    func loadDefaultItems()-> [ItemDef] {
        if let fileLocation = Bundle.main.url(forResource: "defaultItems", withExtension: "json"){
            do{
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let jsonData = try jsonDecoder.decode([ItemDef].self, from: data)
                return jsonData
            }
            catch{
                print("Error: error decoding json")
            }
        }
        return []
    }

    private static func getFileURL(tripID: UUID?) throws -> URL {
        var fileName = "items.data"
        if let tripID = tripID {
            fileName = "items_\(tripID.uuidString).data"
        }
        return try FileManager.default.url(for: .documentDirectory,
                                           in: .userDomainMask,
                                           appropriateFor: nil,
                                           create: false)
            .appendingPathComponent(fileName)
    }
}
