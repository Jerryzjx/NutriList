//
//  SignOutView.swift
//  NutriList
//
//  Created by leonard on 2024-01-07.
//

import SwiftUI

struct SignOutView: View {
    @Binding var appUser: AppUser
    @Environment(\.dismiss) var dismiss
    var body: some View {
        if appUser != nil {
            Button {
                Task{
                    do {
                        try await AuthManager.shared.signOut()
                        dismiss()
                        ContentView(appUser: nil)
                    } catch {
                        print("unable to sign out")
                    }
                }
            } label: {
                Text("Sign Out")
                    .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    SignOutView(appUser: .constant(.init(uid: "1234", email: "jerry@gmail.com")))
}
