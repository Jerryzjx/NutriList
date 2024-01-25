//
//  ContentView.swift
//  NutriList
//
//  Created by leonard on 2024-01-07.
//

import SwiftUI

struct ContentView: View {
    @State var appUser: AppUser? = nil
    @StateObject var authManager = AuthManager.shared
    var body: some View {
        ZStack {
            if authManager.isAuthenticated {
                if let appUser = appUser {
                    ToDoView(appUser: appUser)
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut(duration: 0.45))
                } else {
                    SignInView(appUser: $appUser)
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut(duration: 0.45))
                }
            } else {
                SignInView(appUser: $appUser)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut(duration: 0.45))
            }
            
        }
        .onAppear {
            Task {
                self.appUser = try await AuthManager.shared.getCurrentSession()
            }
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appUser: nil)
    }
}
