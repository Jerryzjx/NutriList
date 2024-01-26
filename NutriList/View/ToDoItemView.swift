//
//  ToDoItemView.swift
//  NutriList
//
//  Created by leonard on 2024-01-07.
//

import SwiftUI

struct ToDoItemView: View {
    @EnvironmentObject var viewModel: ToDoViewModel
    @State var todo: ToDo
    @State private var isSelected: Bool = false
    @State var appUser: AppUser

    var body: some View {
        HStack {
            // Toggleable Circle SF Symbol
            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                .font(.system(size: 28, weight: .regular))
                .frame(width: 44, height: 44)
                .foregroundColor(isSelected ? .green : .primary)
                .padding(.leading, 20)
                .onTapGesture {
                    isSelected = true
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    Task {
                        do {
                            try await viewModel.deleteItem(todo: todo)
                            // wait for a second before deleting the item
                            try await Task.sleep(nanoseconds: 1_000_000_000)
                            isSelected = false // Set isSelected to true only if deletion is successful
                        } catch {
                            print("Error deleting item: \(error)")
                            UINotificationFeedbackGenerator().notificationOccurred(.error)
                            isSelected = false // Reset isSelected to false if deletion fails
                        }
                    }
                }
            VStack(alignment: .listRowSeparatorLeading, spacing: 3) {
                HStack {
                    // Grocery Text
                    Text(todo.text)
                        .font(.headline)
                        .fontWeight(.medium)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }

                HStack {
                    // Category Information
                    Text(todo.category)
                        .offset(x:3, y:0)
                        .font(.subheadline)
                        .foregroundColor(Color("LightGray"))
                    Spacer()
                }
            }
            .frame(maxWidth:.infinity, alignment: .leading)
            .frame(height: 70, alignment: .leading)
            .clipped()


            Spacer()
        }
        .frame(height: 70)
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 15)
        )
        .padding([.leading, .trailing], 10)
        .onDisappear{
            
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

// Preview
struct ToDoItemView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoItemView(todo: .init(id: 0, createdAt: "", text: "Apple", userUid: "", category: "Fruit"), appUser: AppUser(uid: "", email: ""))
            .environmentObject(ToDoViewModel())
    }
}
