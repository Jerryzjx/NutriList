//
//  DatabaseManager.swift
//  NutriList
//
//  Created by leonard on 2024-01-07.
//

import Foundation
import Supabase

class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private init(){}
    
    let client = SupabaseClient(supabaseURL: "URL", supabaseKey: "KEY")
    
    func createToDOItem(item: ToDoPayload) async throws {
        let response = try await client.database.from("todos").insert(item).execute()
       // print(response)
       // print(response.status)
       // print(response.data)
    }
    
    func fetchToDoItems(for uid: String) async throws -> [ToDo] {
        let response = try await client.database.from("todos").select().equals("user_uid", value: uid).order("created_at", ascending: true).execute()
        let data = response.data
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let todos = try decoder.decode([ToDo].self, from: data)
       // print(todos)
        return todos
    }
    
    func deleteToDoItem(id: Int) async throws {
        let response = try await client.database.from("todos").delete().eq("id", value: id).execute()
       // print(response)
       // print(response.status)
       // print(String(data: response.data, encoding: .utf8))
    }
}
