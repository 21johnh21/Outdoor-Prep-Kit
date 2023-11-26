//
//  ContentView.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/26/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Trip.timestamp, ascending: true)],
        animation: .default)
    private var trips: FetchedResults<Trip>

    var body: some View {
        NavigationView {
            List {
                ForEach(trips) { trip in
                    NavigationLink {
                        Text("Trip at \(trip.timestamp!, formatter: tripFormatter)")
                    } label: {
                        Text(trip.timestamp!, formatter: tripFormatter)
                    }
                }
                .onDelete(perform: deleteTrips)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Edit") {
                        // Your edit action here
                    }
                }
                ToolbarItem {
                    Button(action: addTrip) {
                        Label("Add Trip", systemImage: "plus")
                    }
                }
            }
            Text("Select a trip")
        }
    }

    private func addTrip() {
        withAnimation {
            let newTrip = Trip(context: viewContext)
            newTrip.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteTrips(offsets: IndexSet) {
        withAnimation {
            offsets.map { trips[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let tripFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

// Preview code
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
