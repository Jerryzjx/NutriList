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
        // Simulate database insertion
               mockToDoItems.append(ToDo(id: mockToDoItems.count + 1,
                                         createdAt: "",
                                         text: item.text,
                                         userUid: item.userUid,
                                         category: item.category))
    }

    func fetchToDoItems(for uid: String) async throws -> [ToDo] {
        if shouldReturnError {
            throw NSError(domain: "Mock Error", code: 0, userInfo: nil)
        }
        return mockToDoItems.filter { $0.userUid == uid }
    }

    func deleteToDoItem(id: Int) async throws {
        if shouldReturnError {
            throw NSError(domain: "Mock Error", code: 0, userInfo: nil)
        }
        mockToDoItems.removeAll { $0.id == id }
    }

    // Load mock data from a JSON file
    func loadMockData(filename: String) {
            mockToDoItems = loadJSON(filename: filename, type: ToDo.self)
        }
}
