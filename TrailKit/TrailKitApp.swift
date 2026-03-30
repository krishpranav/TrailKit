//
//  TrailKitApp.swift
//  TrailKit
//
//  Created by Krisna Pranav on 30/03/26.
//

import SwiftUI
import SwiftData

@main
struct TrailKitApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Hike.self)
    }
}
