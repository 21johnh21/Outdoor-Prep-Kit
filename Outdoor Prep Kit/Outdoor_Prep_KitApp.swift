//
//  Outdoor_Prep_KitApp.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/26/23.
//

import SwiftUI

@main
struct Outdoor_Prep_KitApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
