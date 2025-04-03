//
//  LoginViewModel.swift
//  HealthApp
//
//  Created by Fernando Archila on 02.04.25.
//

import Foundation
import Combine

final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isAuthenticating = false
    @Published var isAuthenticatingsso = false
    @Published var showError = false
    @Published var shouldNavigate = false
    @Published var isLoggedIn = false

    func authenticateLocalUser() {
        isAuthenticating = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if self.email.lowercased() == "test@healthapp.com" && self.password == "test" {
                self.showError = false
                self.shouldNavigate = true
            } else {
                self.showError = true
                self.shouldNavigate = false
            }
            self.isAuthenticating = false
        }
    }

    func authenticateUser() {
        isAuthenticatingsso = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.isLoggedIn = true
            self.shouldNavigate = true
            self.isAuthenticatingsso = false
        }
    }
}
