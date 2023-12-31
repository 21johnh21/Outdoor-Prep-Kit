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
    @State private var isAddingTrip = false
    @State private var selection: Trip?

    var body: some View {
        NavigationView {
            List(selection: $selection){
                ForEach(trips) { trip in
                    NavigationLink(
                        destination: TripDetail(trip: trip)){
                        TripCard(trip: trip)
                    }
                }
                .onDelete(perform: deleteTrips)
            }
            .navigationTitle("Outdoor Prep Kit")
            .sheet(isPresented: $isAddingTrip) {
                NavigationStack {
                    AddTripView()
            }
                .presentationDetents([.medium, .large])
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Edit") {
                        // Your edit action here
                    }
                }
                ToolbarItem {
                    Button(action: {
                        isAddingTrip = true}) {
                        Image(systemName: "plus")
                    }
                }
            }
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
