//
//  ToDoViewModel.swift
//  NutriList
//
//  Created by leonard on 2024-01-07.
//

import Foundation

class ToDoViewModel: ObservableObject {
    private let databaseService: DatabaseService
    
    init(databaseService: DatabaseService = DatabaseManager.shared) {
        self.databaseService = databaseService
    }
    
    @Published var todos = [ToDo]()
    
    
    // MARK: Create
    func createItem(text: String, uid: String, category: String) async throws {
        guard !todos.contains(where: { $0.text.lowercased() == text.lowercased() }) else {
            print("Already in todo list")
            throw NSError()
        }
        
        let toDo = ToDoPayload(text: text, userUid: uid, category: category)
        //print("Creating todo item")
        try await databaseService.createToDoItem(item: toDo)
    }
    
    // MARK: Read
    @MainActor
    func fetchItems(for uid: String) async throws {
        todos = try await databaseService.fetchToDoItems(for: uid)
    }
    
    // MARK: Delete
    @MainActor
    func deleteItem(todo: ToDo) async throws {
        try await databaseService.deleteToDoItem(id: todo.id)
        todos.removeAll(where: { $0.id == todo.id })
    }
}
