//
//  MockURLSession.swift
//  Workday
//
//  Created by Franco Fantillo on 2022-12-13.
//

import Foundation

//MARK: MOCK

enum MockURLSessionTestCase: Int {
    case success = 0
    case fail400 = 1
    case fail500 = 2
    case caseNil = 3
    case lengthyTask = 4
}

class MockURLSession: URLSessionProtocol {

    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?
    var testCase: MockURLSessionTestCase
    
    init(testCase: MockURLSessionTestCase, nextDataTask: MockURLSessionDataTask = MockURLSessionDataTask(), nextData: Data? = nil, nextError: Error? = nil) {
        self.nextDataTask = nextDataTask
        self.nextData = nextData
        self.nextError = nextError
        self.testCase = testCase
    }
    
    private (set) var lastURL: URL?
    
    func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    func successLengthyHttpURLResponse(request: URLRequest) -> URLResponse {
        do { sleep(4) }
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    func failHttpURLResponse400(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 400, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    func failHttpURLResponse500(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 500, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        
        var response: URLResponse?
        switch testCase {
        case .success:
            response = successHttpURLResponse(request: request)
        case .fail400:
            response = failHttpURLResponse400(request: request)
        case .fail500:
            response = failHttpURLResponse500(request: request)
        case .caseNil:
            response = nil
        case .lengthyTask:
            response = successLengthyHttpURLResponse(request: request)
        }
        
        completionHandler(nextData, response, nextError)
        return nextDataTask
    }
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    
    private (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}
