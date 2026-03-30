//
//  Hike.swift
//  TrailKit
//
//  Created by Krisna Pranav on 30/03/26.
//

import SwiftData
import Foundation

@Model
final class Hike {
    var name: String
    var distanceKm: Double
    var durationMinutes: Int
    var date: Date
    var elevationGain: Double
    var isCompleted: Bool = false

    @Relationship(deleteRule: .cascade)
    var waypoints: [Waypoint] = []

    init(name: String, distanceKm: Double,
         durationMinutes: Int,
         date: Date = .now,
         elevationGain: Double) {
        self.name = name
        self.distanceKm = distanceKm
        self.durationMinutes = durationMinutes
        self.date = date
        self.elevationGain = elevationGain
    }
}

@Model
final class Waypoint {
    var title: String
    var latitude: Double
    var longitude: Double

    init(title: String, latitude: Double, longitude: Double) {
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
    }
}
