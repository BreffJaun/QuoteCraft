//
//  Projektwoche1App.swift
//  Projektwoche1
//
//  Created by Jana Jansen on 24.01.25.
//

import SwiftUI
import SwiftData

@main
struct Projektwoche1App: App {
    
    // Picker Style 😎
    //.https://stackoverflow.com/questions/57735761/how-to-change-selected-segment-color-in-swiftui-segmented-picker
    init() {
        let pinkAccent = UIColor(named: "PinkAccent")!

        // Aktives Segment: Hintergrund pink, Text weiß
        UISegmentedControl.appearance().selectedSegmentTintColor = pinkAccent
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.white],
            for: .selected
        )

        // Inaktive Segmente: Text pink
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.white],
            for: .normal
        )
    }
    
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
//                .modelContainer(for: [User.self, Quote.self])
                .modelContainer(DataManager.container)
        }
    }
}
