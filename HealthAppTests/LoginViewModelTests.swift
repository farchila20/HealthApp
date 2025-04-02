//
//  LoginViewModelTests.swift
//  HealthAppTests
//
//  Created by Fernando Archila on 02.04.25.
//

import XCTest
@testable import HealthApp

final class LoginViewModelTests: XCTestCase {
    var viewModel: LoginViewModel!

    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel()
    }

    func testAuthenticateLocalUser_Success() {
        viewModel.email = "test@healthapp.com"
        viewModel.password = "test"

        let expectation = XCTestExpectation(description: "Valid login should succeed")

        viewModel.authenticateLocalUser()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertTrue(self.viewModel.shouldNavigate)
            XCTAssertFalse(self.viewModel.showError)
            XCTAssertFalse(self.viewModel.isAuthenticating)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }

    func testAuthenticateLocalUser_Failure() {
        viewModel.email = "wrong@email.com"
        viewModel.password = "wrongpass"

        let expectation = XCTestExpectation(description: "Invalid login should fail")

        viewModel.authenticateLocalUser()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertFalse(self.viewModel.shouldNavigate)
            XCTAssertTrue(self.viewModel.showError)
            XCTAssertFalse(self.viewModel.isAuthenticating)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }

    func testAuthenticateUser_OAuthFlow() {
        let expectation = XCTestExpectation(description: "OAuth login should complete")

        viewModel.authenticateUser()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            XCTAssertTrue(self.viewModel.isLoggedIn)
            XCTAssertTrue(self.viewModel.shouldNavigate)
            XCTAssertFalse(self.viewModel.isAuthenticatingsso)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3)
    }
}
