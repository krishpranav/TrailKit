//
//  MeshBackgroundView.swift
//  TrailKit
//
//  Created by Krisna Pranav on 31/03/26.
//

import SwiftUI

struct MeshBackgroundView: View {
    @State private var phase: Bool = false

    var body: some View {
        MeshGradient(
            width: 3,
            height: 3,
            points: phase ? animatedPoints : staticPoints,
            colors: phase ? warmColors : coolColors
        )
        .ignoresSafeArea()
        .onAppear {
            withAnimation(
                .easeInOut(duration: 4)
                .repeatForever(autoreverses: true)
            ) {
                phase.toggle()
            }
        }
    }

    let staticPoints: [SIMD2<Float>] = [
        [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
        [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
        [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
    ]

    let animatedPoints: [SIMD2<Float>] = [
        [0.0, 0.0], [0.4, 0.0], [1.0, 0.0],
        [0.0, 0.6], [0.6, 0.4], [1.0, 0.5],
        [0.0, 1.0], [0.6, 1.0], [1.0, 1.0]
    ]

    let coolColors: [Color] = [
        .blue, .indigo, .purple,
        .cyan, .mint, .teal,
        .blue, .green, .teal
    ]

    let warmColors: [Color] = [
        .orange, .yellow, .red,
        .pink, .purple, .indigo,
        .teal, .green, .mint
    ]
}
