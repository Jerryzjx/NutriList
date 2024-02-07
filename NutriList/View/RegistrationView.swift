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
        VStack(spacing: 30) {
            Spacer()
            Spacer()
            AppIcon()
            Text("Sign Up")
                .font(.largeTitle)
                .bold()
                .lineSpacing(0.83)
                .foregroundColor(.white)
                .fixedSize(horizontal: false, vertical: true)
                .frame(width: UIScreen.main.bounds.width * 0.85, alignment: .topLeading)
                .padding([.leading, .trailing])
            
            VStack (spacing: 10){
                AppTextField(placeHolder: "Enter Your Email address", text: $email)
                AppSecureField(placeHolder: "Password at least 7 characters long", text: $password)
            }
            .padding(.horizontal, 24)
            
            
            Button {
                Task {
                    do {
                        let user = try await viewModel.registerNewUserWithEmail(email: email, password: password)
                                                self.appUser = appUser
                                                dismiss.callAsFunction()
                    } catch {
                        print("issue with sign in")
                        UINotificationFeedbackGenerator().notificationOccurred(.error)
                        self.alertMessage = "Invalid email format or password is less than 7 characters."
                        self.showAlert = true
                    }
                }
            } label: {
                Text("Sign up")
                    .font(Font.system(size: 23))
                    .fontWeight(.semibold)
                    .padding()
                    .foregroundColor(Color(uiColor: .white))
                    .frame(maxWidth:.infinity)
                    .frame(height: 55)
            }
            .background {
                RoundedRectangle(cornerRadius: 15, style: .continuous).foregroundColor(Color("LightTeal"))
            }
            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1)), radius: 4, x: 0, y: 2)
            .padding(.horizontal, 24)
            .alert(isPresented: $showAlert) { // Alert modifier
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            Spacer()
            Spacer()
        }
        .padding(10)
        .background(Color("DarkTeal"))
    }
    
}

#Preview {
    RegistrationView(appUser: .constant(.init(uid: "1234", email: nil)))
        .environmentObject(SignInViewModel())
}
