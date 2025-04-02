//
//  LoginViewUITests.swift
//  HealthAppUITests
//
//  Created by Fernando Archila on 02.04.25.
//

import XCTest

final class LoginViewUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }

    func testSuccessfulLoginWithValidCredentials() {
        let emailField = app.textFields["emailField"]
        let passwordField = app.secureTextFields["passwordField"]
        let loginButton = app.buttons["localLoginButton"]

        XCTAssertTrue(emailField.waitForExistence(timeout: 5))
        emailField.tap()
        emailField.typeText("test@healthapp.com")

        passwordField.tap()
        passwordField.typeText("test")

        loginButton.tap()

        let documentListTitle = app.navigationBars["Documents"]
        XCTAssertTrue(documentListTitle.waitForExistence(timeout: 3))
    }

    func testFailedLoginShowsError() {
        let emailField = app.textFields["emailField"]
        let passwordField = app.secureTextFields["passwordField"]
        let loginButton = app.buttons["localLoginButton"]

        emailField.tap()
        emailField.typeText("wrong@example.com")

        passwordField.tap()
        passwordField.typeText("wrongpass")

        loginButton.tap()

        let errorText = app.staticTexts["loginErrorLabel"]
        XCTAssertTrue(errorText.waitForExistence(timeout: 2))
    }


}
