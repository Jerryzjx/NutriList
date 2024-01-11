//
//  ToDoViewModelTests.swift
//  NutriListTests
//
//  Created by leonard on 2024-01-11.
//
import Combine
import XCTest
@testable import NutriList

class ToDoViewModelTests: XCTestCase {
    
    var viewModel: ToDoViewModel!
    var mockDB: MockDatabaseManager!
    
    private var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        mockDB = MockDatabaseManager()
        mockDB.loadMockData(filename: "Supabase")
        viewModel = ToDoViewModel(databaseService: mockDB)
    }

    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
        mockDB = nil
    }
    
    func testFetchToDoItems_Success() async throws {
        // Assuming supabase.json contains at least one ToDo item for this user ID
        try await viewModel.fetchItems(for: "b36639fd-5854-4651-b205-935e82aa899d")
        
        // Replace these assertions with the expected results based on your mock data
        XCTAssertGreaterThan(viewModel.todos.count, 0)
        XCTAssertEqual(viewModel.todos.first?.userUid, "b36639fd-5854-4651-b205-935e82aa899d")
    }

    
    func testFetchToDoItems_Failure() async throws {
        mockDB.shouldReturnError = true
        
        do {
            try await viewModel.fetchItems(for: "b36639fd-5854-4651-b205-935e82aa899d")
            XCTFail("Expected an error to be thrown")
        } catch {
            // Test passed, error was thrown as expected
        }
    }
    
    func testCreateToDoItem_Success() async throws {
        let newItem = ToDoPayload(text: "New Item", userUid: "user123", category: "General")
        
        try await viewModel.createItem(text: newItem.text, uid: newItem.userUid, category: newItem.category)
        
        XCTAssertEqual(viewModel.todos.count, 1)
        XCTAssertEqual(viewModel.todos.first?.text, "New Item")
    }
    
    func testCreateToDoItem_Failure() async throws {
        mockDB.shouldReturnError = true
        
        let newItem = ToDoPayload(text: "New Item", userUid: "user123", category: "General")
        
        do {
            try await viewModel.createItem(text: newItem.text, uid: newItem.userUid, category: newItem.category)
            XCTFail("Expected an error to be thrown")
        } catch {
            // Test passed, error was thrown as expected
        }
    }
    
    func testDeleteToDoItem_Success() async throws {
        // Pre-populate with an item
        let existingItem = ToDo(id: 1, createdAt: "", text: "Existing Item", userUid: "user123", category: "General")
        mockDB.mockToDoItems = [existingItem]
        
        try await viewModel.fetchItems(for: "user123") // Load items into viewModel
        try await viewModel.deleteItem(todo: existingItem)
        
        XCTAssertTrue(viewModel.todos.isEmpty)
    }
    
    func testDeleteToDoItem_Failure() async throws {
        // Pre-populate with an item
        let existingItem = ToDo(id: 1, createdAt: "", text: "Existing Item", userUid: "user123", category: "General")
        mockDB.mockToDoItems = [existingItem]
        mockDB.shouldReturnError = true
        
        try await viewModel.fetchItems(for: "user123") // Load items into viewModel
        
        do {
            try await viewModel.deleteItem(todo: existingItem)
            XCTFail("Expected an error to be thrown")
        } catch {
            // Test passed, error was thrown as expected
        }
    }
}


