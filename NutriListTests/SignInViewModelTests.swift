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
    }

    override func tearDown() {
        super.tearDown()
        mockAuthManager = nil
        viewModel = nil
    }

    func testRegisterNewUserWithEmail() async throws {
        // Mock AuthManager to return a success response
        let user = try await viewModel.registerNewUserWithEmail(email: "test@example.com", password: "012345678")
        XCTAssertEqual(user.email, "test@example.com")
        // Add more assertions as needed
    }
    
    func testRegisterNewUserWithEmailInvalidEmail() async throws {
        let email = "test"
        let password = "12345678"
        
        do {
            _ = try await viewModel.registerNewUserWithEmail(email: email, password: password)
            XCTFail("Expected failure due to invalid email, but succeeded")
        } catch {
            // Error thrown as expected, no need to check specific error details
        }
    }
    
    func testRegisterNewUserWithEmailShortPassword() async throws {
        let email = "valid@example.com"
        let password = "1234"
        
        do {
            _ = try await viewModel.registerNewUserWithEmail(email: email, password: password)
            XCTFail("Expected failure due to short password, but succeeded")
        } catch {
            // Error thrown as expected, no need to check specific error details
        }
    }

    func testSignInWithEmailSuccess() async throws {

        do {
            let user = try await viewModel.signInWithEmail(email: "user@example.com", password: "password123")
            XCTAssertEqual(user.email, "user@example.com")
        } catch let error as NSError {
            XCTAssertEqual(error.domain, "Mock Error")
            XCTAssertEqual(error.code, 2)
        }
    }
    
    func testSignInWithEmailFailure() async throws {

        do {
            _ = try await viewModel.signInWithEmail(email: "invalid@example.com", password: "password")
            XCTFail("Expected failure on sign-in, but succeeded")
        } catch {
            // Optionally, assert specific error details here
        }
    }
    
    func testSignInWithInvalidEmail() async throws {

        do {
            _ = try await viewModel.signInWithEmail(email: "test", password: "password")
            XCTFail("Expected failure on sign-in, but succeeded")
        } catch {
            // Optionally, assert specific error details here
        }
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

