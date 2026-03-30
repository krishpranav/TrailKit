//
//  HikeStore.swift
//  TrailKit
//
//  Created by Krisna Pranav on 30/03/26.
//

import Observation
import Foundation


@Observable
final class HikeStore {
    var selectedHike: Hike? = nil
    var searchText: String = ""
    var isLoading: Bool = false

    var hasSelection: Bool {
        selectedHike != nil
    }

    func selectedHike(_ hike: Hike) {
        selectedHike = hike
    }

    func clearSelection() {
        selectedHike = nil
    }
}
