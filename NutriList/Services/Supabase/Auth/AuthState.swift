//
//  AuthState.swift
//  NutriList
//
//  Created by leonard on 2024-01-08.
//

import Foundation
class AuthState: ObservableObject {
    @Published var isAuthenticated: Bool = false
    
    // MARK: Sign In
    func signIn() {
        isAuthenticated = true
    }
    // MARK: Sign Out
    func signOut() {
        isAuthenticated = false
    }
}
