//
//  ContentView.swift
//  TrailKit
//
//  Created by Krisna Pranav on 30/03/26.
//

import SwiftUI

struct ContentView: View {
    @State private var store = HikeStore()
    @State private var selectedTab: AppTab = .hikes

    enum AppTab {
        case hikes, charts, explore, settings
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Hikes", systemImage: "figure.hiking",
                value: AppTab.hikes) {
                HikeListView()
            }

            Tab("Charts", systemImage: "chart.xyaxis.line",
                value: AppTab.hikes) {
            }

            Tab("Explore", systemImage: "safari",
                value: AppTab.hikes) {
                ExploreWebView()
            }

            Tab("Settings", systemImage: "gearshape",
                value: AppTab.hikes) {
            }
        }

        .tabViewStyle(.sidebarAdaptable)
        .environment(store)
    }
}

#Preview {
    ContentView()
}
