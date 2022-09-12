//
//  CurrencyServiceTests.swift
//  BaluchonTests
//
//  Created by Déborah Suon on 20/12/2021.
//

import XCTest
@testable import Baluchon

class CurrencyServiceTests: XCTestCase {
    
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionConfiguration
    }()
    
    func testGetRateShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        URLProtocolFake.fakeURLs = [FakeResponseData.fixerUrl: (FakeResponseData.fixerData, FakeResponseData.responseKO, nil)]
        let currencyService = CurrencyService(currencySession: URLSession(configuration: sessionConfiguration))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        currencyService.fetchCurrency() { result in
            // Then
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertTrue(error == .invalidResponse)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRateShouldPostFailedCallbackIfIncorrectData() {
        // Given
        URLProtocolFake.fakeURLs = [FakeResponseData.fixerUrl: (FakeResponseData.incorrectData, FakeResponseData.responseOK, nil)]
        let currencyService = CurrencyService(currencySession: URLSession(configuration: sessionConfiguration))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        currencyService.fetchCurrency() { result in
            // Then
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertTrue(error == .undecodableData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRateShouldPostFailedCallbackIfNoData() {
        // Given
        URLProtocolFake.fakeURLs = [FakeResponseData.fixerUrl: (nil, nil, FakeResponseData.error)]
        let currencyService = CurrencyService(currencySession: URLSession(configuration: sessionConfiguration))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        currencyService.fetchCurrency() { result in
            // Then
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertTrue(error == .noData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.02)
    }
    
}
   
