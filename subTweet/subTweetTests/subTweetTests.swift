//
//  subTweetTests.swift
//  subTweetTests
//
//  Created by Trong Ton on 6/12/18.
//  Copyright © 2018 trong.ton2003@gmail.com. All rights reserved.
//

import XCTest
@testable import subTweet

class subTweetTests: XCTestCase {
    var vcInput: ViewController!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc: ViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        vcInput = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        _ = vcInput.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        vcInput.inputTextView.text = "The quick brown fox jumps over the lazy dog"
        vcInput.sentButton.sendActions(for: .touchUpInside)
        if vcInput.dataSource.count <= 0 {
            XCTFail("Expected error with T weet don't insert")
        }
    }
    
    func testExampleWith87Character() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        vcInput.inputTextView.text = "The quick brown fox jumps over the lazy dog The quick brown fox jumps over the lazy dog"
        vcInput.sentButton.sendActions(for: .touchUpInside)
        if vcInput.dataSource.count < 2 || vcInput.dataSource.count > 2 {
            XCTFail("Expected error with Tweet was split wrong")
        }
    }
    
    func testExampleWithNoWhiteSpaceCharacter() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        vcInput.inputTextView.text = "ThequickbrownfoxjumpsoverthelazydogThequickbrownfoxjumpsoverthelazydog"
        vcInput.sentButton.sendActions(for: .touchUpInside)
        if vcInput.dataSource.count > 0 {
            XCTFail("Expected error with wrong Tweet was insert")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
