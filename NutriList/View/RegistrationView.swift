//
//  RegistrationView.swift
//  NutriList
//
//  Created by leonard on 2024-01-07.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: SignInViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Binding var appUser: AppUser?
    
    var body: some View {
        VStack {
            VStack (spacing: 10){
                AppTextField(placeHolder: "Enter Your Email address", text: $email)
                AppSecureField(placeHolder: "Password at least 7 characters long", text: $password)
            }
            .padding(.horizontal, 24)
        }
        
        Button {
            Task {
                do {
                    let user = try await viewModel.registerNewUserWithEmail(email: email, password: password)
                    self.appUser = appUser
                    dismiss.callAsFunction()
                } catch {
                    print("issue with sign in")
                    self.alertMessage = "Invalid email or password."
                    self.showAlert = true
                }
            }
        } label: {
            Text("Register")
                .padding()
                .foregroundColor(Color(uiColor: .systemBackground))
                .frame(maxWidth:.infinity)
                .frame(height: 55)
                .background {
                    RoundedRectangle(cornerRadius: 20, style: .continuous).foregroundColor(Color(uiColor: .label))
                }
        }
        .padding(.top, 12)
        .padding(.horizontal, 24)
        .alert(isPresented: $showAlert) { // Alert modifier
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
    }
    
}

#Preview {
    RegistrationView(appUser: .constant(.init(uid: "1234", email: nil)))
        .environmentObject(SignInViewModel())
}
