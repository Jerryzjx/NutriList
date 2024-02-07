//
//  SignInAppleView.swift
//  NutriList
//
//  Created by leonard on 2024-02-06.
//

import SwiftUI
import AuthenticationServices
import Supabase


struct SignInAppleView: View {
    let client = SupabaseClient(supabaseURL: URL(string: "https://hwzaoukqpaejfcfmhqbs.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh3emFvdWtxcGFlamZjZm1ocWJzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQ2NDU3MDUsImV4cCI6MjAyMDIyMTcwNX0.hyH8J5nGOIgXUzplOQqtF0WI2nqbZWnU4bYKjPYi4HE")

    var body: some View {
      SignInWithAppleButton { request in
        request.requestedScopes = [.email, .fullName]
      } onCompletion: { result in
        Task {
          do {
            guard let credential = try result.get().credential as? ASAuthorizationAppleIDCredential
            else {
              return
            }

            guard let idToken = credential.identityToken
              .flatMap({ String(data: $0, encoding: .utf8) })
            
            else {
              return
            }
              print(idToken)
              try await client.auth.signInWithIdToken(
              credentials: .init(
                provider: .apple,
                idToken: idToken
              )
            )
          } catch {
            dump(error)
          }
        }
      }
      .fixedSize()
    }
}
