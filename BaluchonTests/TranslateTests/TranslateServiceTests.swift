//
//  TranslateServiceTests.swift
//  BaluchonTests
//
//  Created by Déborah Suon on 10/01/2022.
//

import XCTest
@testable import Baluchon


class TranslateServiceTests: XCTestCase {

    // test callback return error
    func testTranslateShouldPostFailedCallbackIfError() {
        let translate = TranslateService(translateSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translate.translate(language: .fr, text: "Bonjour") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // test callback doesn't return data
    func testTranslateShouldPostFailedCallbackIfNoData() {
        let translate = TranslateService(translateSession: URLSessionFake(data: nil, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translate.translate(language: .fr, text: "Bonjour") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // test callback return incorrect response
    func testTranslateShouldPostFailedCallbackIncorrectResponse() {
        let translate = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.translateData, response: FakeResponseData.responseKO, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translate.translate(language: .fr, text: "Bonjour") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // test callback return incorrect data
    func testTranslateShouldPostFailedCallbackIncorrectData() {
        let translate = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translate.translate(language: .fr, text: "Bonjour") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
  
}
