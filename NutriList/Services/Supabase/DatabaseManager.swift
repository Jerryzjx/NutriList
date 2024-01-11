//
//  DatabaseManager.swift
//  NutriList
//
//  Created by leonard on 2024-01-07.
//

import Foundation
import Supabase


enum DatabaseError: Error {
    case badResponse, errorDecodingData, operationFailed
}

protocol DatabaseService {
    func createToDoItem(item: ToDoPayload) async throws
    func fetchToDoItems(for uid: String) async throws -> [ToDo]
    func deleteToDoItem(id: Int) async throws
}

class DatabaseManager: DatabaseService {
    
    static let shared = DatabaseManager()
    private init() {}
    
    let client = SupabaseClient(supabaseURL: "URL", supabaseKey: "KEY")
    
    func createToDoItem(item: ToDoPayload) async throws {
        let response = try await client.database.from("todos").insert(item).execute()
        
        guard response.status == 200 else {
            throw DatabaseError.badResponse
        }
    }
    
    func fetchToDoItems(for uid: String) async throws -> [ToDo] {
        let response = try await client.database.from("todos").select().equals("user_uid", value: uid).order("created_at", ascending: true).execute()
        
        guard response.status == 200 else {
            throw DatabaseError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let todos = try decoder.decode([ToDo].self, from: response.data)
            return todos
        } catch {
            throw DatabaseError.errorDecodingData
        }
    }

    
    func deleteToDoItem(id: Int) async throws {
        let response = try await client.database.from("todos").delete().eq("id", value: id).execute()
        
        guard response.status == 200 else {
            throw DatabaseError.operationFailed
        }
    }
}
