//
//  ThemeKitDemoApp.swift
//  ThemeKitDemo
//
//  Created by Max Rozdobudko on 2/18/26.
//

import SwiftUI

@main
struct ThemeKitDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.theme, .default)
        }
    }
}
