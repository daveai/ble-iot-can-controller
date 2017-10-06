//
//  CementechThunderboltUITests.swift
//  CementechThunderboltUITests
//
//  Created by Debashis Banerjee on 05/10/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import XCTest

class CementechThunderboltUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testAllControlExistInLoginScreen() {
        //given
        let app = XCUIApplication()
        let txtEmail = app.textFields["txtEmail"]
        let txtPassword = app.textFields["txtPassword"]
        let btnLogin = app.buttons["btnLogin"]
        let btnForgot = app.buttons["btnForgot"]
        //then
        XCTAssertTrue(txtEmail.exists)
        XCTAssertTrue(txtPassword.exists)
        XCTAssertTrue(btnLogin.exists)
        XCTAssertTrue(btnForgot.exists)
    }
    func testAllTheControlsHasEqualWidthOfLoginButton(){
        //given
        let app = XCUIApplication()
        let txtEmail = app.textFields["txtEmail"]
        let txtPassword = app.textFields["txtPassword"]
        let btnLogin = app.buttons["btnLogin"]
        let btnLoginWidth = btnLogin.frame.width
        let txtEmailWidth = txtEmail.frame.width
        let txtPasswordWidth = txtPassword.frame.width
        //then
        XCTAssertTrue(btnLoginWidth.isEqual(to: txtEmailWidth))
        XCTAssertTrue(btnLoginWidth.isEqual(to: txtPasswordWidth))
    }
    func testKeyboardShouldShowAfterTappingTxtFields(){
        //given
        let app = XCUIApplication()
        let txtEmail = app.textFields["txtEmail"]
        let txtPassword = app.textFields["txtPassword"]
        //then
        txtEmail.tap()
        XCTAssert(app.keyboards.count > 0, "The keyboard is not shown")
        txtPassword.tap()
        XCTAssert(app.keyboards.count > 0, "The keyboard is not shown")
    }
    func testLoginButtonShouldVisibleOnKeyboardAppears(){
        //given
        let app = XCUIApplication()
        let txtEmail = app.textFields["txtEmail"]
        let btnLogin = app.buttons["btnLogin"]
        //then
        txtEmail.tap()
        XCTAssert(app.keyboards.count > 0, "The keyboard is not shown")
        let keyboard = app.keyboards
        print(keyboard.accessibilityFrame.origin.y)
        XCTAssert(keyboard.accessibilityFrame.origin.y < btnLogin.frame.origin.y, "Login button must above the keyboard")
        
    }
    func testControllsShouldBeCenterOfTheScreenHorizontally(){
        //given
        let app = XCUIApplication()
        let txtEmail = app.textFields["txtEmail"]
        let btnLogin = app.buttons["btnLogin"]
        let txtPassword = app.textFields["txtPassword"]
        let superView = app.otherElements["superView"]
        //then
        XCTAssert(superView.frame.midX.isEqual(to: txtEmail.frame.midX), "Email field is not centered horizontally")
        XCTAssert(superView.frame.midX.isEqual(to: btnLogin.frame.midX), "Login button is not centered horizontally")
        XCTAssert(superView.frame.midX.isEqual(to: txtPassword.frame.midX), "Password field is not centered horizontally")
        
    }
    
}
