//
//  FileMetaDataView.swift
//  HealthApp
//
//  Created by Fernando Archila on 02.04.25.
//

import SwiftUI

import SwiftUI

struct FileMetadataView: View {
    let fileURL: URL
    @State private var fileSize: String = "Loading..."
    @State private var creationDate: String = "Loading..."
    @State private var modificationDate: String = "Loading..."
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("File: \(fileURL.lastPathComponent)")
                .font(.headline)
            Text("Size: \(fileSize)")
            Text("Created: \(creationDate)")
            Text("Modified: \(modificationDate)")
        }
        .padding()
        .onAppear {
            fetchMetadata()
        }
    }
    
    func fetchMetadata() {
        let resourceKeys: Set<URLResourceKey> = [.fileSizeKey, .creationDateKey, .contentModificationDateKey]
        
        do {
            let resourceValues = try fileURL.resourceValues(forKeys: resourceKeys)
            
            if let size = resourceValues.fileSize {
                fileSize = ByteCountFormatter.string(fromByteCount: Int64(size), countStyle: .file)
            }
            
            if let created = resourceValues.creationDate {
                creationDate = formatDate(created)
            }
            
            if let modified = resourceValues.contentModificationDate {
                modificationDate = formatDate(modified)
            }
        } catch {
            print("Error fetching metadata: \(error.localizedDescription)")
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
