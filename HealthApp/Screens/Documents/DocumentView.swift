//
//  DocumentView.swift
//  HealthApp
//
//  Created by Fernando Archila on 02.04.25.
//

import SwiftUI

struct DocumentView: View {
    let documentURL: URL
    
    @State private var showShareSheet = false
    @State private var showQuickLook = false
    
    var body: some View {
        VStack {
            if documentURL.pathExtension.lowercased() == "pdf" {
                PDFKitView(url: documentURL)
                    .frame(maxHeight: .infinity)
            } else {
                Button("Preview Document") {
                    showQuickLook.toggle()
                }
                .quickLookPreview($showQuickLook, items: [documentURL])
            }
            
            HStack {
                
                NavigationLink( destination: FileMetadataView(fileURL: documentURL)){
                    
                    HStack {
                        Label("Show MetaData", systemImage: "info.circle")
                    }
                    .frame(maxWidth: 150)
                    .padding()
                    .foregroundColor(.blue)
                    .cornerRadius(10)
                }
                
                Button(action: deleteDocument) {
                    Label("Delete", systemImage: "trash")
                        .foregroundColor(.red)
                }
                .padding()
                
            }
        }
        .navigationTitle(documentURL.lastPathComponent)
    }
    
    func deleteDocument() {
        do {
            try FileManager.default.removeItem(at: documentURL)
            print("Document deleted")
        } catch {
            print("Error deleting document: \(error.localizedDescription)")
        }
    }
}
