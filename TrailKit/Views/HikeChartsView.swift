//
//  HikeChartsView.swift
//  TrailKit
//
//  Created by Krisna Pranav on 30/03/26.
//

import SwiftUI
import Charts
import SwiftData

struct HikeChartsView: View {
    @Query(sort: \.date) var hikes: [Hike]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 28) {
                    GroupBox("Elevation Profile (Simulated)") {
                        Chart {
                            LinePlot(
                                x: "Distance (km)",
                                y: "Elevation (m)"
                            ) { x in
                                sin(x * 0.8) * 80 + 200
                            }
                            .foregroundStyle(.blue.gradient)
                            .lineStyle(StrokeStyle(lineWidth: 2.5))
                        }
                        .chartXScale(domain: 0...20)
                        .chartYScale(domain: 0...400)
                        .chartTitle("Altitude over Distance")
                        .frame(height: 200)
                    }

                    GroupBox("Distance Per Hike") {
                        Chart(hikes) { hike in
                            BarMark(
                                x: .value("Date", hike.date, unit: .day),
                                y: .value("km", hike.distanceKm)
                            )
                            .foregroundStyle(
                                hike.isCompleted ? .green.gradient : .orange.gradient
                            )
                            .cornerRadius(4)
                        }
                        .chartScrollableAxes(.horizontal)
                        .chartXVisibleDomain(length: 7 * 86400)
                        .frame(height: 200)
                    }

                    GroupBox("Distance vs Elevation Gain") {
                        Chart(hikes) { hike in
                            PointMark(
                                x: .value("Distance", hike.distanceKm),
                                y: .value("Elevation", hike.elevationGain)
                            )
                            .symbolSize(80)
                            .foregroundStyle(.purple.gradient)
                            .annotation(position: .top) {        
                                Text(hike.name)
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .frame(height: 220)
                    }
                }
                .padding()
            }
            .navigationTitle("Analytics")
        }
    }
}
