//
//  WeatherServiceTests.swift
//  BaluchonTests
//
//  Created by Déborah Suon on 20/12/2021.
//

import XCTest
@testable import Baluchon

class WeatherServiceTests: XCTestCase {

    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionConfiguration
    }()

    func testGetRateShouldPostFailedCallbackIfNoData() {
        // Given
        URLProtocolFake.fakeURLs = [FakeResponseData.weatherUrl: (nil, nil, FakeResponseData.error)]
        let weatherService = WeatherService(weatherSession: URLSession(configuration: sessionConfiguration))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.fetchWeather() { result in
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
    
    
    func testGetRateShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        URLProtocolFake.fakeURLs = [FakeResponseData.weatherUrl: (FakeResponseData.weatherData, FakeResponseData.responseKO, nil)]
        let weatherService = WeatherService(weatherSession: URLSession(configuration: sessionConfiguration))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.fetchWeather() { result in
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
        URLProtocolFake.fakeURLs = [FakeResponseData.weatherUrl: (FakeResponseData.incorrectData, FakeResponseData.responseOK, nil)]
        let weatherService = WeatherService(weatherSession: URLSession(configuration: sessionConfiguration))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.fetchWeather() { result in
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
    
}
