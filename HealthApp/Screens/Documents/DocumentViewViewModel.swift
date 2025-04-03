//
//  DocumentViewViewModel.swift
//  HealthApp
//
//  Created by Fernando Archila on 02.04.25.
//
import Foundation
import SwiftUI

@MainActor
class DocumentViewerViewModel: ObservableObject {
    @Published var documents: [URL] = []
    @Published var isPickerPresented = false
    @Published var hasConsent = false
    @Published var isUploading = false
    @Published var uploadSuccess: Bool?
    @Published var errorMessage: String?

    private let uploader: FileUploaderService

    init(uploader: FileUploaderService ) {
        self.uploader = uploader
    }

    func deleteDocument(at offsets: IndexSet) {
        documents.remove(atOffsets: offsets)
    }

    func uploadDocument(fileURL: URL) async {
        isUploading = true
        let success = await uploader.upload(fileURL: fileURL)
        isUploading = false
        uploadSuccess = success
        errorMessage = success ? nil : "Upload failed"

        if success {
            documents.append(fileURL)
        }
    }

    func provideConsent() {
        hasConsent = true
    }
}
