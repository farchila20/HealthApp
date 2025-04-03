//
//  UploadFeedBack.swift
//  HealthApp
//
//  Created by Fernando Archila on 02.04.25.
//

import SwiftUI


struct UploadStatusView: View {
    let isUploading: Bool
    let uploadSuccess: Bool
    let errorMessage: String?
    
    var body: some View {
        VStack(spacing: 10) {
            if isUploading {
                ProgressView("Uploading...")
            }
            
            if uploadSuccess {
                Text("✅ Upload successful!")
                    .foregroundColor(.green)
            }
            
            if let error = errorMessage {
                Text("❌ \(error)")
                    .foregroundColor(.red)
            }
        }
    }
}
