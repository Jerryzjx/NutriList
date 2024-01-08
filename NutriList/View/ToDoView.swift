//
//  ToDoView.swift
//  NutriList
//
//  Created by leonard on 2024-01-07.
//

import SwiftUI

struct ToDoView: View {
    @StateObject var viewModel = ToDoViewModel()
    
    @State var appUser: AppUser
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(viewModel.todos, id: \.text){ todo in
                            ToDoItemView(todo: todo)
                                .environmentObject(viewModel)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            .background(Color(red: 39/255, green: 40/255, blue: 39/255))
            .navigationTitle("Grocery List")
            .toolbar {
                
                HStack {
                    NavigationLink {
                        SignOutView(appUser: $appUser)
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .padding(.all, 2)
                            .foregroundColor(Color(red: 62/255, green: 207/255, blue: 142/255))
                }
                    NavigationLink {
                        CreateToDoView(appUser: appUser)
                            .environmentObject(viewModel)
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .padding(.all, 2)
                            .foregroundColor(Color(red: 62/255, green: 207/255, blue: 142/255))
                }
                }
                
            }
            .onAppear{
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
}

#Preview {
    ToDoView(appUser: .init(uid: "", email: ""))
}
