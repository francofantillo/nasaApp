//
//  NasaAppTests.swift
//  NasaAppTests
//
//  Created by Franco Fantillo
//

import XCTest
import Foundation
import SwiftUI
@testable import NasaApp

final class NetworkTests: XCTestCase {

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
    
    func test_get_request_with_URL() async {

        let expectedData = "{}".data(using: .utf8)
        sessionSuccess.nextData = expectedData
        
        guard let url = URL(string: "https://mockurl") else {
            fatalError("URL can't be empty")
        }
        
        _ = try! await httpClientSuccess.getData(url: url)
        
        XCTAssert(sessionSuccess.lastURL == url)
        
    }
    
    func test_get_resume_called() async {
        
        let expectedData = "{}".data(using: .utf8)
        sessionSuccess.nextData = expectedData
        
        let dataTask = MockURLSessionDataTask()
        sessionSuccess.nextDataTask = dataTask
        
        guard let url = URL(string: "https://mockurl") else {
            fatalError("URL can't be empty")
        }
        
        _ = try! await httpClientSuccess.getData(url: url)
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func test_get_should_return_data() async {
        let expectedData = "{}".data(using: .utf8)
        
        sessionSuccess.nextData = expectedData
        let data = try! await httpClientSuccess.getData(url: URL(string: "http://mockurl")!)
        XCTAssertNotNil(data)
    }
    
    func test_get_should_return_apiError400() async {
    
        let errorData = APIErrorMessage(error: true, reason: "Test Error")
        let encoder = JSONEncoder()
        let encoded = try! encoder.encode(errorData)
        
        sessionFail400.nextData = encoded
        
        do {
            _ = try await httpClientFail400.getData(url: URL(string: "http://mockurl")!)
            fatalError("Should produce an error.")
            
        } catch let error as APIErrors {
            XCTAssertNotNil(error)
        }
        catch {
            fatalError("Should catch specific error.")
        }
    }
    
    func test_get_should_return_apiError500() async {
    
        let errorData = APIErrorMessage(error: true, reason: "Test Error")
        let encoder = JSONEncoder()
        let encoded = try! encoder.encode(errorData)
        
        sessionFail500.nextData = encoded
        
        do {
            _ = try await httpClientFail500.getData(url: URL(string: "http://mockurl")!)
            fatalError("Should produce an error.")
            
        } catch let error as APIErrors {
            XCTAssertNotNil(error)
        }
        catch {
            fatalError("Should catch specific error.")
        }
    }
    
    func test_get_should_return_error() async {
        let expectedData = "{}".data(using: .utf8)

        sessionFail400.nextData = expectedData
        
        do {
            _ = try await httpClientFail400.getData(url: URL(string: "http://mockurl")!)
            fatalError("Should produce an error.")
            
        } catch let error as APIErrors {
            XCTAssertNotNil(error)
        }
        catch {
            fatalError("Should catch specific error.")
        }
    }
    
    func test_with_url_response_nil() async {
        
        do {
            _ = try await httpClientNilResponse.getData(url: URL(string: "http://mockurl")!)
            fatalError("Should produce an error.")
            
        } catch let error as APIErrors {
            XCTAssertNotNil(error)
        }
        catch {
            fatalError("Should catch specific error.")
        }
    }
    
    func test_session_transport_error() async {
        
        sessionFail400.nextError = APIErrors.invalidResponseError
        
        do {
            _ = try await httpClientFail400.getData(url: URL(string: "http://mockurl")!)
            fatalError("Should produce an error.")
        } catch let error as APIErrors {
            XCTAssertNotNil(error)
        }
        catch {
            fatalError("Should catch specific error.")
        }
    }
}

