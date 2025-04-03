//
//  DocumentPicker.swift
//  HealthApp
//
//  Created by Fernando Archila on 02.04.25.
//

import PDFKit
import SwiftUI

struct DocumentPicker: UIViewControllerRepresentable {
    @StateObject private var uploader = FileUploaderService()
    var onPick: (URL?) -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onPick: onPick)
    }
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf, .text, .image])
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var onPick: (URL?) -> Void
        
        init(onPick: @escaping (URL?) -> Void) {
            self.onPick = onPick
            
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first else { return }
            NotificationCenter.default.post(name: .didPickFile, object: url)
            onPick(urls.first)
            
        }
        
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            onPick(nil)
        }
    }
}
