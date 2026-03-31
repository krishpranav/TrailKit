//
//  HikeRowView.swift
//  TrailKit
//
//  Created by Krisna Pranav on 30/03/26.
//

import SwiftUI
import SwiftData

struct HikeRowView: View {
    let hike: Hike
    @Environment(\.modelContext) var context

    var body: some View {
        NavigationLink(destination: HikeDetailView(hike: hike)) {
            HStack(alignment: .top, spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(hike.isCompleted ? Color.green.opacity(0.15)
                                               : Color.blue.opacity(0.15))
                        .frame(width: 52, height: 52)

                    Image(systemName: hike.isCompleted
                          ? "checkmark.seal.fill"
                          : "figure.hiking")
                        .font(.system(size: 22))
                        .foregroundStyle(hike.isCompleted ? .green : .blue)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(hike.name)
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .lineLimit(1)

                    HStack(spacing: 10) {
                        Label("\(hike.distanceKm, format: .number.precision(.fractionLength(1))) km",
                              systemImage: "arrow.triangle.swap")
                        Label("\(hike.durationMinutes) min",
                              systemImage: "clock")
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)

                    HStack(spacing: 10) {
                        Label("\(Int(hike.elevationGain))m gain",
                              systemImage: "arrow.up.right")
                        Label(hike.date.formatted(date: .abbreviated,
                                                  time: .omitted),
                              systemImage: "calendar")
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }

                Spacer()

                Button {
                    toggleComplete()
                } label: {
                    Image(systemName: hike.isCompleted
                          ? "checkmark.circle.fill"
                          : "circle")
                        .font(.title2)
                        .foregroundStyle(hike.isCompleted ? .green : .gray.opacity(0.4))
                        .contentTransition(.symbolEffect(.replace))
                }
                .buttonStyle(.plain)
            }
            .padding(.vertical, 6)
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button {
                toggleComplete()
            } label: {
                Label(
                    hike.isCompleted ? "Undo" : "Done",
                    systemImage: hike.isCompleted
                        ? "arrow.uturn.backward"
                        : "checkmark.seal.fill"
                )
            }
            .tint(hike.isCompleted ? .orange : .green)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button(role: .destructive) {
                context.delete(hike)
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }

    func toggleComplete() {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
            hike.isCompleted.toggle()
        }
    }
}
