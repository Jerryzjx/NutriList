//
//  SignInViewModelTests.swift
//  NutriListTests
//
//  Created by leonard on 2024-01-11.
//

import XCTest
@testable import NutriList

class SignInViewModelTests: XCTestCase {

    var viewModel: SignInViewModel!
    var mockAuthManager: MockAuthManager!


    @MainActor override func setUp() {
        super.setUp()
        mockAuthManager = MockAuthManager()
        viewModel = SignInViewModel(authManager: mockAuthManager)
        // Mock the AuthManager and SignInApple here if needed
    }

    override func tearDown() {
        super.tearDown()
        mockAuthManager = nil
        viewModel = nil
    }

    /*func testIsFormValid() {
        DispatchQueue.main.sync {
            XCTAssertTrue(viewModel.isFormValid(email: "test@example.com", password: "12345678"))
            XCTAssertFalse(viewModel.isFormValid(email: "test", password: "1234"))
        }
    }*/


    func testRegisterNewUserWithEmail() async throws {
        // Mock AuthManager to return a success response
        let user = try await viewModel.registerNewUserWithEmail(email: "test@example.com", password: "012345678")
        XCTAssertEqual(user.email, "test@example.com")
        // Add more assertions as needed
    }

    func testSignInWithEmail() async throws {
        // Similar to testRegisterNewUserWithEmail
    }

    func testSignInWithApple() async throws {
        // Mock signInApple and AuthManager as needed
    }

    func testIsValidEmail() {
        // Valid email formats
        XCTAssertTrue("test@example.com".isValidEmail())
        XCTAssertTrue("user.name+tag+sorting@example.com".isValidEmail())
        XCTAssertTrue("user.name@example.co.in".isValidEmail())
        XCTAssertTrue("username023@uwaterloo.ca".isValidEmail())
        XCTAssertTrue("user-name@example.info".isValidEmail())
        XCTAssertTrue("user_name@example.cn".isValidEmail())
        XCTAssertTrue("username@yahoo.corporate.in".isValidEmail())
        XCTAssertTrue("1234567890@example.com".isValidEmail())
        XCTAssertTrue("email@subdomain.example.com".isValidEmail())
        XCTAssertTrue("firstname-lastname@example.com".isValidEmail())

        // Invalid email formats
        XCTAssertFalse("test".isValidEmail())
        XCTAssertFalse("".isValidEmail())
        XCTAssertFalse(" ".isValidEmail())
        XCTAssertFalse("                      ".isValidEmail())
        XCTAssertFalse("name@123.123.123.1234".isValidEmail())
        XCTAssertFalse("name@domain".isValidEmail())
        XCTAssertFalse("name@domain.".isValidEmail())
        XCTAssertFalse("name@domain.c".isValidEmail())
        XCTAssertFalse("name@_domain.com".isValidEmail())
    }

}

