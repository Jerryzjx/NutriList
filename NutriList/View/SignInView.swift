//
//  SignInView.swift
//  NutriList
//
//  Created by leonard on 2024-01-07.
//

import SwiftUI

struct SignInView: View {
    @StateObject var viewModel = SignInViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var isRegisterationPresented = false
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @Binding var appUser: AppUser?
    var body: some View {
        VStack (spacing: 30) {
            Spacer()
            Spacer()
            Spacer()
            AppIcon()
            
            
            WelcomeText()
                .frame(width: UIScreen.main.bounds.width * 0.85, alignment: .topLeading)
                .padding([.leading, .trailing]) // You might adjust this padding as needed
            
            
            VStack (spacing: 10){
                AppTextField(placeHolder: "Email address", text: $email)
                AppSecureField(placeHolder: "Password", text: $password)
            }
            .padding(.horizontal, 24)
            
            
            
            Button {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                Task {
                    do {
                        let appUser = try await viewModel.signInWithEmail(email: email, password: password)
                        self.appUser = appUser
                    } catch {
                        self.alertMessage = "Issue with sign in. Please check your email and password."
                        self.showAlert = true
                        print("issue with sign in")
                        // failure haptic effect
                        UINotificationFeedbackGenerator().notificationOccurred(.error)
                    }
                }
            } label: {
                Text("Sign in")
                    .font(Font.system(size: 21))
                    .fontWeight(.semibold)
                    .padding()
                    .foregroundColor(Color(uiColor: .white))
                    .frame(maxWidth:.infinity)
                    .frame(height: 55)
            }
            .background {
                RoundedRectangle(cornerRadius: 15, style: .continuous).foregroundColor(Color(uiColor: .systemTeal))
            }
            .padding(.horizontal, 24)
            
            VStack (spacing: 20){
                Button {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    Task {
                        do {
                            let appUser = try await viewModel.signInWithApple()
                            self.appUser = appUser
                        } catch {
                            print("error signing in with apple")
                        }
                    }
                } label: {
                    Text("Sign in with Apple")
                        .font(Font.system(size: 18))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(Color(uiColor: .white))
                }
                .background {
                    RoundedRectangle(cornerRadius: 15, style: .continuous).foregroundColor(Color(uiColor: .black))
                }
                
                Button("Don't have an account? Sign Up") {
                    isRegisterationPresented.toggle()
                }
                .font(Font.system(size: 18))
                .foregroundColor(Color(uiColor: .white))
                .sheet(isPresented: $isRegisterationPresented) {
                    RegistrationView(appUser: $appUser)
                        .environmentObject(viewModel)
                }
                Spacer()
                Spacer()
            }
                .padding(.top)
                .padding(.horizontal, 24)
                
                .alert(isPresented: $showAlert) { // Alert modifier
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
            .padding(10)
            .background(Color("DarkTeal"))
            
        }
    }
    
    struct SignInView_Previews: PreviewProvider {
        static var previews: some View {
            SignInView(appUser: .constant(.init(uid: "1234", email: nil)))
        }
    }
