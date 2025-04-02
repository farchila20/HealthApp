////
////  DocumentViewerTests.swift
////  HealthApp
////
////  Created by Fernando Archila on 02.04.25.
////
//
//import XCTest
//import SwiftUI
//import ViewInspector
//@testable import HealthApp
//
//final class DocumentViewerTests: XCTestCase {
//
//    func testInitialStateWithoutConsent() throws {
//        let sut = DocumentViewer()
//        let exp = sut.inspect().find(text: "Your Documents will be visible here once the consent is provided")
//        XCTAssertNoThrow(try exp)
//    }
//
//    func testConsentFlowShowsDocumentList() throws {
//        var sut = DocumentViewer()
//        sut.hasConsent = true
//
//        let view = try sut.inspect()
//        XCTAssertNoThrow(try view.find(viewWithId: "DocumentsList"))
//    }
//
//    func testAddDocumentAppendsToList() async throws {
//        var sut = DocumentViewer()
//        sut.hasConsent = true
//        let dummyURL = URL(string: "file:///dummy.pdf")!
//
//        await MainActor.run {
//            sut.documents.append(dummyURL)
//        }
//
//        XCTAssertEqual(sut.documents.count, 1)
//        XCTAssertEqual(sut.documents.first, dummyURL)
//    }
//
//    func testDeleteDocumentRemovesFromList() throws {
//        var sut = DocumentViewer()
//        sut.documents = [
//            URL(string: "file:///doc1.pdf")!,
//            URL(string: "file:///doc2.pdf")!
//        ]
//
//        sut.deleteDocument(at: IndexSet(integer: 0))
//
//        XCTAssertEqual(sut.documents.count, 1)
//        XCTAssertEqual(sut.documents.first?.lastPathComponent, "doc2.pdf")
//    }
//
//    func testEmptyStateAppearsWhenNoDocuments() throws {
//        var sut = DocumentViewer()
//        sut.hasConsent = true
//        sut.documents = []
//
//        let view = try sut.inspect()
//        XCTAssertNoThrow(try view.find(EmptyState.self))
//    }
//}
