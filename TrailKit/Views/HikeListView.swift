//
//  HikeListView.swift
//  TrailKit
//
//  Created by Krisna Pranav on 30/03/26.
//

import SwiftUI
import SwiftData

struct HikeListView: View {
    @Environment(\.modelContext) var context
    @Environment(HikeStore.self) var store

    @Query(
        filter: #Predicate<Hike> { $0.isCompleted == false },
        sort: \.date,
        order: .reverse
    )
    var pendingHikes: [Hike]

    @Query(
        filter: #Predicate<Hike> { $0.isCompleted == true },
        sort: \.date, order: .reverse
    )

    var completedHikes: [Hike]

    var body: some View {
        NavigationStack {
            List {
                if !pendingHikes.isEmpty {
                    Section("Upcoming") {
                        ForEach(pendingHikes) { hike in
                            HikeRowView(hike: hike)
                        }
                        .onDelete(perform: deleteHikes)         // 12
                    }
                }

                if !completedHikes.isEmpty {
                    Section("Completed") {
                        ForEach(completedHikes) { hike in
                            HikeRowView(hike: hike)
                        }
                    }
                }
            }
            .navigationTitle("TrailKit")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {        
                    Button("Add Hike", systemImage: "plus") {
                        addSampleHike()
                    }
                }
            }
        }
    }

    func deleteHikes(at offsets: IndexSet) {
        for index in offsets {
            context.delete(pendingHikes[index])
        }
    }

    func addSampleHike() {
        let hike = Hike(
            name: "Bukit Timah Trail",
            distanceKm: 8.5,
            durationMinutes: 120,
            elevationGain: 163
        )
        context.insert(hike)
    }
}



#Preview {
    HikeListView()
}
