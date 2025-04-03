//
//  EmptyState.swift
//  HealthApp
//
//  Created by Fernando Archila on 02.04.25.
//

import SwiftUI

struct EmptyState:View {
    
    var body: some View {
        VStack {
            Image(systemName: "tray.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
            
            Text("No items found")
                .font(.headline)
                .foregroundColor(.gray)
                .padding()
                .accessibilityLabel("emptyStateText")
                .accessibilityIdentifier("emptyStateText")
        } .accessibilityIdentifier("emptyStateContainer")
        
        
    }
    
}
