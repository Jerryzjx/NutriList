//
//  SignInViewModel.swift
//  NutriList
//
//  Created by leonard on 2024-01-07.
//

import Foundation

@MainActor
class SignInViewModel: ObservableObject {
    
    let signInApple = SignInApple()
    
    func isFormValid(email:String, password: String) -> Bool {
        guard email.isValidEmail(), password.count > 7 else {
            return false
        }
        return true
    }
    
    
    func registerNewUserWIthEmail(email:String, password: String) async throws -> AppUser {
        if isFormValid(email: email, password: password) {
            return try await AuthManager.shared.registerNewUserWithEmail(email: email, password: password)
        } else {
            print("registration form is invalid")
            throw NSError()
        }
       
    }
    
    func signInWithEmail(email:String, password: String) async throws -> AppUser {
        if isFormValid(email: email, password: password) {
            return try await AuthManager.shared.signInWithEmail(email: email, password: password)
        } else {
            print("registration form is invalid")
            throw NSError()
        }
    }
    
    func signInWithApple() async throws -> AppUser{
        let appleResult = try await signInApple.startSignInWithAppleFlow()
        return try await AuthManager.shared.signInWithApple(idToken: appleResult.idToken, nonce: appleResult.nonce)
    }

}

extension String {
    
    func isValidEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)

    }
}
