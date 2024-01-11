//
//  AuthManager.swift
//  NutriList
//
//  Created by leonard on 2024-01-07.
//

import Foundation
import Supabase

struct AppUser {
    let uid: String
    let email: String?
}

class AuthManager: ObservableObject{
    
    static let shared = AuthManager()
    
    private init(){}
    
    @Published var isAuthenticated = false
    @Published var currentUser: AppUser?
    
    let client = SupabaseClient(supabaseURL: "URL", supabaseKey: "KEY")
    
    func getCurrentSession() async throws -> AppUser {
        let session = try await client.auth.session
        return AppUser(uid: session.user.id.uuidString, email:session.user.email)
    }
    
    // MARK: Registeration
    func registerNewUserWithEmail(email:String, password: String) async throws -> AppUser {
        let regAuthResponse = try await client.auth.signUp(email: email, password: password)
        guard let session = regAuthResponse.session else {
            print("no session when registering user")
            throw NSError()
        }
        return AppUser(uid: session.user.id.uuidString, email:session.user.email)
    }
    
    
    // MARK: Sign In
    func signInWithEmail(email: String, password: String) async throws -> AppUser {
        let session = try await client.auth.signIn(email: email, password: password)
        DispatchQueue.main.async {
                    self.isAuthenticated = true
                }
        return AppUser(uid: session.user.id.uuidString, email:session.user.email)
    }
    
    func signInWithApple(idToken: String, nonce: String) async throws -> AppUser {
        let session = try await client.auth.signInWithIdToken(credentials: .init(provider: .apple, idToken: idToken, nonce: nonce))
        DispatchQueue.main.async {
                    self.isAuthenticated = true
                }
        return AppUser(uid: session.user.id.uuidString, email:session.user.email)
    }
    
    func signOut() async throws {
            try await client.auth.signOut()
            DispatchQueue.main.async {
                self.isAuthenticated = false
            }
        }
}
