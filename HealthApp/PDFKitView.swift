//
//  PDFKitView.swift
//  HealthApp
//
//  Created by Fernando Archila on 02.04.25.
//

import SwiftUI
import PDFKit
import QuickLook

struct PDFKitView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ pdfView: PDFView, context: Context) {}
}
