//
//  ToDoViewModel.swift
//  NutriList
//
//  Created by leonard on 2024-01-07.
//

import Foundation

class ToDoViewModel: ObservableObject {
    
    @Published var todos = [ToDo]()
    
    
    // MARK: Create
    func createItem(text: String, uid: String, category: String) async throws {
        guard !todos.contains(where: { $0.text.lowercased() == text.lowercased() }) else {
            print("Already in todo list")
            throw NSError()
        }
        
        let toDo = ToDoPayload(text: text, userUid: uid, category: category)
            //print("Creating todo item")
        try await DatabaseManager.shared.createToDOItem(item: toDo)
    }
    
    // MARK: Read
    @MainActor
    func fetchItems(for uid: String) async throws {
       todos = try await DatabaseManager.shared.fetchToDoItems(for: uid)
    }
    
    // MARK: Delete
    @MainActor
    func deleteItem(todo: ToDo) async throws {
        try await DatabaseManager.shared.deleteToDoItem(id: todo.id)
        todos.removeAll(where: { $0.id == todo.id })
    }
}
