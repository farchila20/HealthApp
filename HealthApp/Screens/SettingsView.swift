//
//  SettingsView.swift
//  HealthApp
//
//  Created by Fernando Archila on 02.04.25.
//

import SwiftUI

struct SettingsView: View {
    @State private var notificationsEnabled = true
    @State private var syncOverCellular = false
    @State private var isDarkMode = false
    @State private var showLogoutAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User Info")) {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text("Fernando Example")
                            Text("Fernando.Example@example.com")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                Section(header: Text("Preferences")) {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                    Toggle("Sync Over Cellular", isOn: $syncOverCellular)
                    Toggle("Dark Mode", isOn: $isDarkMode)
                }
                
                Section {
                    Button(role: .destructive) {
                        showLogoutAlert = true
                    } label: {
                        Label("Log Out", systemImage: "rectangle.portrait.and.arrow.right")
                    }
                }
            }
            .navigationTitle("Settings")
            .alert(isPresented: $showLogoutAlert) {
                Alert(
                    title: Text("Log Out"),
                    message: Text("Are you sure you want to log out?"),
                    primaryButton: .destructive(Text("Log Out")),
                    secondaryButton: .cancel()
                )
            }
        }
    }
}

#Preview {
    SettingsView()
}
