//
//  HealthAppApp.swift
//  HealthApp
//
//  Created by Fernando Archila on 29.03.25.
//

import SwiftUI

@main
struct HealthAppApp: App {
    var body: some Scene {
        WindowGroup {
            if ProcessInfo.processInfo.arguments.contains("UI_TESTING_DOCUMENTS") {
                NavigationView {
                    DocumentViewer(documents: [])
                }
            } else {
                LoginView()
            }
        }
    }
}
