//
//  MockDatabaseManager.swift
//  NutriListTests
//
//  Created by leonard on 2024-01-11.
//

import Foundation
@testable import NutriList

class MockDatabaseManager: DatabaseService, Mockable {
    var shouldReturnError = false
    var mockToDoItems: [ToDo] = []

    func createToDoItem(item: ToDoPayload) async throws {
        if shouldReturnError {
            throw NSError(domain: "Mock Error", code: 0, userInfo: nil)
        }
        // Optionally, add item to mockToDoItems to simulate database insertion
    }

    func fetchToDoItems(for uid: String) async throws -> [ToDo] {
        if shouldReturnError {
            throw NSError(domain: "Mock Error", code: 0, userInfo: nil)
        }
        return mockToDoItems
    }

    func deleteToDoItem(id: Int) async throws {
        if shouldReturnError {
            throw NSError(domain: "Mock Error", code: 0, userInfo: nil)
        }
        // Optionally, remove item from mockToDoItems to simulate database deletion
    }

    // Load mock data from a JSON file
    func loadMockData(filename: String) {
            mockToDoItems = loadJSON(filename: filename, type: ToDo.self)
        }
}
