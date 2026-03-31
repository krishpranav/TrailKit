//
//  HikeDetailView.swift
//  TrailKit
//
//  Created by Krisna Pranav on 30/03/26.
//

import SwiftUI

struct HikeDetailView: View {
    let hike: Hike

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                LazyVGrid(
                    columns: [GridItem(.flexible()),
                              GridItem(.flexible())],
                    spacing: 14
                ) {
                    StatCard(label: "Distance",
                             value: "\(hike.distanceKm) km",
                             icon: "arrow.triangle.swap",
                             tint: .blue)

                    StatCard(label: "Duration",
                             value: "\(hike.durationMinutes) min",
                             icon: "clock.fill",
                             tint: .orange)

                    StatCard(label: "Elevation Gain",
                             value: "\(Int(hike.elevationGain)) m",
                             icon: "arrow.up.right",
                             tint: .green)

                    StatCard(label: "Status",
                             value: hike.isCompleted ? "Completed" : "Upcoming",
                             icon: hike.isCompleted ? "checkmark.seal.fill" : "hourglass",
                             tint: hike.isCompleted ? .green : .purple)
                }

                GroupBox {
                    HStack {
                        Label("Scheduled Date", systemImage: "calendar")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(hike.date.formatted(date: .long, time: .omitted))
                            .foregroundStyle(.primary)
                    }
                }

                if !hike.waypoints.isEmpty {
                    GroupBox("Waypoints") {
                        ForEach(hike.waypoints) { wp in
                            HStack {
                                Image(systemName: "mappin.circle.fill")
                                    .foregroundStyle(.red)
                                Text(wp.title)
                                Spacer()
                                Text("\(wp.latitude, format: .number.precision(.fractionLength(4)))°")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }

            }
            .padding()
        }
        .navigationTitle(hike.name)
        .navigationBarTitleDisplayMode(.large)
    }
}

struct StatCard: View {
    let label: String
    let value: String
    let icon: String
    let tint: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(tint)
                Text(label)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Text(value)
                .font(.title3.bold())
                .foregroundStyle(.primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(tint.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .strokeBorder(tint.opacity(0.2), lineWidth: 1)
        )
    }
}
