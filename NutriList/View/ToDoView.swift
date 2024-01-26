//
//  ToDoView.swift
//  NutriList
//
//  Created by leonard on 2024-01-07.
//

import SwiftUI

struct ToDoView: View {
    @StateObject var viewModel = ToDoViewModel()
    @State private var showSignOutAlert = false
    @State private var showingCreateToDo = false
    @State var appUser: AppUser
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(viewModel.todos) { todo in
                            ToDoItemView(todo: todo, appUser: appUser)
                                .environmentObject(viewModel)
                                .padding(.horizontal)
                        }
                    }
                }
                
                // Floating Action Button at the bottom
                VStack {
                    Spacer()
                    HStack {
                        Button(action: {
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            showingCreateToDo.toggle() // Toggle the state to show CreateToDoView
                        }) {
                            HStack(spacing: 12) {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                Text("Add a Grocery Item")
                                    .fontWeight(.medium)
                            }
                            .padding()
                            .foregroundColor(.white)
                            
                            .cornerRadius(40)
                        }
                        .accessibilityIdentifier("Add")
                        .padding(.leading, 20)
                        .padding(.bottom, 20)
                        
                        Spacer()
                    }
                }
                .sheet(isPresented: $showingCreateToDo) {
                                    // Present the CreateToDoView
                                    CreateToDoView(appUser: appUser)
                                        .environmentObject(viewModel)
                                        .presentationDetents([.fraction(0.33)])
                                        .edgesIgnoringSafeArea([.bottom, .horizontal])
                                        .transition(.move(edge: .bottom))
                                }
            }
            .background(Color("DarkTeal"))
            .navigationTitle("NutriList")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    settingsButton
                }
            }
            .onAppear {
                Task {
                    do {
                        try await viewModel.fetchItems(for: appUser.uid)
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
    
    private var settingsButton: some View {
        Button {
            showSignOutAlert = true
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        } label: {
            Image(systemName: "gear")
                .font(.system(size: 23, weight: .medium))
                .frame(width: 44, height: 44)
                .padding(.all, 2)
                .foregroundColor(.white)
        }
        .alert(isPresented: $showSignOutAlert) {
            Alert(title: Text("Sign Out"), message: Text("Are you sure you want to sign out?"), primaryButton: .destructive(Text("Sign Out")) {
                Task {
                    do {
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        try await AuthManager.shared.signOut()
                        appUser = .init(uid: "", email: "")
                    } catch {
                        UINotificationFeedbackGenerator().notificationOccurred(.error)
                        print("unable to sign out")
                    }
                }
            }, secondaryButton: .cancel())
        }
    }
}

// Preview
struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView(appUser: .init(uid: "", email: ""))
    }
}
