//
//  GroceryItemUITests.swift
//  NutriListUITests
//
//  Created by leonard on 2024-01-19.
//

import XCTest

final class GroceryItemUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateToDoItem() throws {
        // UI tests must launch the application that they test.
        let testString = "test@gmail.com"
        let testPassword = "00000000"
       
        
        let app = XCUIApplication()

        
        let EmailTextField = app.textFields["Email address"]
        EmailTextField.tap()
        EmailTextField.typeText(testString)
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText(testPassword)
        
        app.buttons["Sign In"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        app.navigationBars["Grocery List"]/*@START_MENU_TOKEN@*/.buttons["Add"]/*[[".otherElements[\"rectangle.portrait.and.arrow.right\"].buttons[\"Add\"]",".buttons[\"Add\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.textFields["Please enter your task"].tap()
        
        app.textFields["Please enter your task"].typeText("beef")
        
        app.buttons["Create"].tap()
        
        
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
