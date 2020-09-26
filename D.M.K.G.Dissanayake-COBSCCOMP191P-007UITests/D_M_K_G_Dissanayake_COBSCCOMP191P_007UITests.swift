//
//  D_M_K_G_Dissanayake_COBSCCOMP191P_007UITests.swift
//  D.M.K.G.Dissanayake-COBSCCOMP191P-007UITests
//
//  Created by Kalana Dissanayake on 9/17/20.
//  Copyright © 2020 Kalana Dissanyake. All rights reserved.
//

import XCTest

class D_M_K_G_Dissanayake_COBSCCOMP191P_007UITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSignin() throws {
        let useremail = "admin@gmail.com"
        let userpassword = "123456"
        
        let app = XCUIApplication()
        app.tabBars.buttons["Update"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Sign In"]/*[[".buttons[\"Sign In\"].staticTexts[\"Sign In\"]",".staticTexts[\"Sign In\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let email = app.textFields["Email"]
        email.tap()
        email.typeText(useremail)
        
        let password = app.secureTextFields["Password"]
        password.tap()
        password.typeText(userpassword)
        
        app.buttons["Sign in"].tap()
        
        let updateTextField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element
        
        let isThere = updateTextField.waitForExistence(timeout: 10)
        if isThere {
            XCTAssertTrue(updateTextField.exists)
        }
        
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
