//
//  File.swift
//  HealthApp
//
//  Created by Fernando Archila on 02.04.25.
//

import Foundation

struct FileModel: Identifiable, Hashable {
    let id: UUID
    let name: String
    let url: URL
    let dateAdded: Date

    init(url: URL) {
        self.id = UUID()
        self.url = url
        self.name = url.lastPathComponent
        self.dateAdded = Date()
    }
}
