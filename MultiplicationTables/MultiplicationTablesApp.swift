//
//  MultiplicationTablesApp.swift
//  MultiplicationTables
//
//  Created by Vitali Martsinovich on 2023-07-28.
//

import SwiftUI

@main
struct MultiplicationTablesApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            SettingsView()
                .environmentObject(appState)
        }
    }
}
