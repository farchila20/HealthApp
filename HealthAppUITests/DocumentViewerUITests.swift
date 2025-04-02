//
//  DocumentViewerUITests.swift
//  HealthAppUITests
//
//  Created by Fernando Archila on 02.04.25.
//

import Foundation
import XCTest

final class DocumentViewerUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments.append("UI_TESTING")
        app.launch()
    }

    func testConsentFlowAndUIStateChange() {
        let consentButton = app.buttons["consentButton"]
        XCTAssertTrue(consentButton.waitForExistence(timeout: 3))
        consentButton.tap()

        let addButton = app.buttons["addDocumentButton"]
        XCTAssertTrue(addButton.waitForExistence(timeout: 2))

        let emptyState = app.otherElements["emptyState"]
        XCTAssertTrue(emptyState.waitForExistence(timeout: 2))
    }

    func testOpenDocumentPicker() {
        app.buttons["consentButton"].tap()

        let addButton = app.buttons["addDocumentButton"]
        XCTAssertTrue(addButton.waitForExistence(timeout: 3))
        addButton.tap()

        // Here, normally the UIDocumentPicker would show up,
        // but since you can't simulate it in XCUITest,
        // you can assert the sheet exists or skip this.
    }

    func testAddAndDeleteMockDocument() {
        // NOTE: You’d need to inject a mock ViewModel to simulate this
        // or pre-load a test document via launch environment

        // Fake pre-loaded doc row (if test mode is configured)
        let documentRow = app.staticTexts["documentRow_mock.pdf"]
        XCTAssertTrue(documentRow.waitForExistence(timeout: 3))
        documentRow.swipeLeft()
        app.buttons["Delete"].tap()

        XCTAssertFalse(documentRow.exists)
    }
}
