//
//  MockAuthManager.swift
//  NutriListTests
//
//  Created by leonard on 2024-01-11.
//

import Foundation
@testable import NutriList

class MockAuthManager: AuthManaging {
    var isAuthenticated = false
    var currentUser: AppUser?

    func getCurrentSession() async throws -> AppUser {
        // Example: Return a mock user
        return AppUser(uid: "mockUID", email: "mock@example.com")
    }

    func registerNewUserWithEmail(email: String, password: String) async throws -> AppUser {
        // Example: Return a mock user or throw an error based on a condition
        if email.isValidEmail() && password.count > 7 {
            return AppUser(uid: "mockUID", email: email)
        } else {
            throw NSError(domain: "Mock Error", code: 1, userInfo: nil)
        }
    }

    func signInWithEmail(email: String, password: String) async throws -> AppUser {
        // Example: Return a mock user or throw an error based on a condition
        if email == "user@example.com" && password == "password123" {
            isAuthenticated = true
            let user = AppUser(uid: "mockUID", email: email)
            currentUser = user
            return user
        } else {
            throw NSError(domain: "Mock Error", code: 2, userInfo: nil)
        }
    }

    func signInWithApple(idToken: String, nonce: String) async throws -> AppUser {
        // Example: Return a mock user
        return AppUser(uid: "mockAppleUID", email: "appleuser@example.com")
    }

    func signOut() async throws {
        // Simulate sign out
        isAuthenticated = false
        currentUser = nil
    }
}
