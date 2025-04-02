//
//  View+Ext.swift
//  HealthApp
//
//  Created by Fernando Archila on 02.04.25.
//

import Foundation
import SwiftUI

extension View {
    func quickLookPreview(_ isPresented: Binding<Bool>, items: [URL]) -> some View {
        background(QuickLookPreview(isPresented: isPresented, items: items))
    }
}
