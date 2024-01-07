//
//  CreateToDoView.swift
//  NutriList
//
//  Created by leonard on 2024-01-07.
//

import SwiftUI

struct CreateToDoView: View {
    @EnvironmentObject var viewModel: ToDoViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var text = " "
    
    @State var appUser: AppUser
    
    var body: some View {
        VStack (spacing: 30) {
            Text("Create A ToDo")
                .font(.largeTitle)
            
            AppTextField(placeHolder: "Please enter your task", text: $text)
            
            Button {
                if text.count > 2 {
                    Task {
                        do {
                            try await viewModel.createItem(text: text, uid: appUser.uid,
                            category: "Others")
                            dismiss()
                        } catch {
                            print("error")
                        }
                    }
                }
            } label: {
                Text("Create")
                    .padding()
                    .foregroundColor(Color(uiColor: .systemBackground))
                    .frame(maxWidth:.infinity)
                    .frame(height: 55)
                    .background {
                        RoundedRectangle(cornerRadius: 20, style: .continuous).foregroundColor(Color(uiColor: .label))
                    }
            }
            .padding(.horizontal, 24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.all)
    }
}

#Preview {
    CreateToDoView( appUser: .init(uid: "", email: ""))
        .environmentObject(ToDoViewModel())
}
