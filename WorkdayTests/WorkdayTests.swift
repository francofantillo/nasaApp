//
//  WorkdayTests.swift
//  WorkdayTests
//
//  Created by Franco Fantillo on 2022-12-02.
//

import XCTest
import Foundation
import SwiftUI
@testable import Workday

final class WorkdayTests: XCTestCase {

    var httpClientSuccess: HttpClient!
    var httpClientFail400: HttpClient!
    var httpClientFail500: HttpClient!
    var httpClientNilResponse: HttpClient!
    
    let sessionSuccess = MockURLSession(testCase: .success)
    let sessionFail400 = MockURLSession(testCase: .fail400)
    let sessionFail500 = MockURLSession(testCase: .fail500)
    let sessionNil = MockURLSession(testCase: .caseNil)
    
    override func setUp() {
        super.setUp()
        httpClientSuccess = HttpClient(session: sessionSuccess)
        httpClientFail400 = HttpClient(session: sessionFail400)
        httpClientFail500 = HttpClient(session: sessionFail500)
        httpClientNilResponse = HttpClient(session: sessionNil)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_get_request_with_URL() {

        guard let url = URL(string: "https://mockurl") else {
            fatalError("URL can't be empty")
        }
        
        httpClientSuccess.getData(url: url) { (result) in
            // Return data
        }
        
        XCTAssert(sessionSuccess.lastURL == url)
        
    }
    
    func test_get_resume_called() {
        
        let dataTask = MockURLSessionDataTask()
        sessionSuccess.nextDataTask = dataTask
        
        guard let url = URL(string: "https://mockurl") else {
            fatalError("URL can't be empty")
        }
        
        httpClientSuccess.getData(url: url) { (result) in
            // Return data
        }
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func test_get_cancel_called() {
        
        let dataTask = MockURLSessionDataTask()
        sessionSuccess.nextDataTask = dataTask
        
        guard let url = URL(string: "https://mockurl") else {
            fatalError("URL can't be empty")
        }
        
        httpClientSuccess.getData(url: url) { (result) in
            // Return data
        }
        httpClientSuccess.getData(url: url) { (result) in
            // Return data
        }
        
        XCTAssert(dataTask.cancelWasCalled)
    }
    
    func test_get_should_return_data() {
        let expectedData = "{}".data(using: .utf8)
        
        sessionSuccess.nextData = expectedData
        
        var actualData: Data?
        httpClientSuccess.getData(url: URL(string: "http://mockurl")!) { (result) in
            switch result {
            case .success(let data):
                actualData = data
            case .failure(_):
                fatalError("This should not fail.")
            }
        }
        
        XCTAssertNotNil(actualData)
    }
    
    func test_get_should_return_apiError400() {
    
        let errorData = APIErrorMessage(error: true, reason: "Test Error")
        let encoder = JSONEncoder()
        let encoded = try! encoder.encode(errorData)
        
        sessionFail400.nextData = encoded
        
        var testError: Error?
        httpClientFail400.getData(url: URL(string: "http://mockurl")!) { (result) in
            switch result {
            case .success(_):
                fatalError("This should not succeed.")
            case .failure(let error):
                testError = error
            }
        }

        XCTAssertNotNil(testError)
    }
    
    func test_get_should_return_apiError500() {
    
        let errorData = APIErrorMessage(error: true, reason: "Test Error")
        let encoder = JSONEncoder()
        let encoded = try! encoder.encode(errorData)
        
        sessionFail500.nextData = encoded
        
        var testError: Error?
        httpClientFail500.getData(url: URL(string: "http://mockurl")!) { (result) in
            switch result {
            case .success(_):
                fatalError("This should not succeed.")
            case .failure(let error):
                testError = error
            }
        }

        XCTAssertNotNil(testError)
    }
    
    func test_get_should_return_error() {
        let expectedData = "{}".data(using: .utf8)

        sessionFail400.nextData = expectedData
        
        var testError: Error?
        httpClientFail400.getData(url: URL(string: "http://mockurl")!) { (result) in
            switch result {
            case .success(_):
                fatalError("This should not succeed.")
            case .failure(let error):
                testError = error
            }
        }

        XCTAssertNotNil(testError)
    }
    
    func test_with_url_response_nil() {
        
        var testError: Error?
        httpClientNilResponse.getData(url: URL(string: "http://mockurl")!) { (result) in
            switch result {
            case .success(_):
                fatalError("This should not succeed.")
            case .failure(let error):
                testError = error
            }
        }

        XCTAssertNotNil(testError)
    }
    
    func test_session_transport_error() {
        
        sessionFail400.nextError = APIErrors.invalidResponseError
        
        var testError: Error?
        httpClientFail400.getData(url: URL(string: "http://mockurl")!) { (result) in
            switch result {
            case .success(_):
                fatalError("This should not succeed.")
            case .failure(let error):
                testError = error
            }
        }

        XCTAssertNotNil(testError)
    }
}

