//
//  FileUploader.swift
//  HealthApp
//
//  Created by Fernando Archila on 02.04.25.
//
import Foundation
import Combine
import SwiftUI

class FileUploaderService: ObservableObject {
    @Published var isUploading = false
    @Published var uploadSuccess = false
    @Published var errorMessage: String?
    @State private var pendingDocument: URL?
    
    func upload(fileURL: URL)  async -> Bool{
        await MainActor.run {
            self.isUploading = true
            self.uploadSuccess = false
            self.errorMessage = nil
        }
        
        // Simulate delay
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        let success =  Bool.random()
        
        await MainActor.run {
            self.isUploading = false
            
            if success {
                self.uploadSuccess = true
            } else {
                self.errorMessage = "Upload failed"
            }
        }
        
        return success
    }
    func uploadEncrypted(data: Data, metadata: [String: String]) {
        isUploading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.isUploading = false
            self.uploadSuccess = true
            print("📤 Uploaded encrypted file: \(metadata["filename"] ?? "unknown")")
        }
    }
    
}
