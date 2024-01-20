

//
//  LoginViewUITests.swift
//  NutriListUITests
//
//  Created by leonard on 2024-01-11.
//

import XCTest



class LoginViewUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
    }
    
    func testTypingInAppTextField() throws {
        let app = XCUIApplication()
        app.launch()
        
        let textField = app.textFields["Email address"]
           XCTAssertTrue(textField.exists)
           textField.tap()
           textField.typeText("test@example.com")
        
        // Assert that the text field contains the expected text
        // Note: The text field's value attribute might not directly reflect the input text in some cases,
        // due to the way SwiftUI updates the view. If this assertion fails, you might need to explore
        // alternative ways to verify the text, such as checking the state of the view model.
        XCTAssertEqual(textField.value as? String, "test@example.com", "Text field did not contain the expected text")
    }
    
    
    func testSignIn() throws {
        // UI tests must launch the application that they test.
        let testString = "test@gmail.com"
        let testPassword = "00000000"
        
        let app = XCUIApplication()
        
        let EmailTextField = app.textFields["Email address"]
        EmailTextField.tap()
        EmailTextField.typeText(testString)
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText(testString)
        
        app.buttons["Sign In"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testRegisterUser() throws {
        let testString = "qwer123@gmail.com"
        let testPassword = "12345678"
        let app = XCUIApplication()
        app.launch()

        app.buttons["New User? Register Here"].tap()

        let registerEmailTextField = app.textFields["Enter Your Email address"]
        registerEmailTextField.tap() // First tap to ensure focus
        registerEmailTextField.typeText(testString)

        // Wait for and interact with the password secure text field
        let passwordSecureTextField = app.secureTextFields["Password at least 7 characters long"]
        passwordSecureTextField.tap() // Ensure the secure text field is focused
        passwordSecureTextField.typeText(testPassword) // Type the password

        app.buttons["Register"].tap()

        // Assuming there is a wait for the next screen to load
        // ...

        // Wait for and interact with the sign-in email address text field
        let signInEmailAddressTextField = app.textFields["Email address"]
        signInEmailAddressTextField.tap() // Ensure the text field is focused
        signInEmailAddressTextField.typeText(testString) // Type the email address

        // Wait for and interact with the sign-in password secure text field
        let signInPasswordSecureTextField = app.secureTextFields["Password"]
        signInPasswordSecureTextField.tap() // Ensure the secure text field is focused
        signInPasswordSecureTextField.typeText(testPassword) // Type the password

        app.buttons["Sign In"].tap()
    }

    
}

