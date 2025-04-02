//
//  DocumentListItem.swift
//  HealthApp
//
//  Created by Fernando Archila on 02.04.25.
//

import SwiftUI

struct DocumentListItem: View {
    
    
    @State private var document: URL
    
    init(document: URL){
        self.document = document
        print(document)
    }
    
    var body: some View {
        HStack{
            Image(systemName: "doc")
            
            Text(document.lastPathComponent)
            
        }
    }
}
