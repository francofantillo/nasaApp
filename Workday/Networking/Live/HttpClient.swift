//
//  HttpClient.swift
//  Workday
//
//  Created by Franco Fantillo on 2022-12-10.
//

import Foundation

// Protocol for MOCK/Real
protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
    func cancel()
}

//MARK: HttpClient Implementation
class HttpClient {
    
    typealias completeClosure = ( _ result: Result<(Data, URLResponse), Error>) -> Void
    
    private let session: URLSessionProtocol
    
    private var dataTask: URLSessionDataTaskProtocol!
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func getData(url: URL, result: @escaping (Result<Data, APIErrors>) ->Void){
        
        // Check if another task is running and cancel it if it is
        if let task = dataTask {
            task.cancel()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        dataTask = session.dataTask(with: request) { [weak self] (data, response, error) in
            
            guard let self = self else {
                result(.failure(APIErrors.validationError("Self is out of scope.")))
                return
            }
            
            if let error = error {
                if error.localizedDescription == "cancelled" {
                    return
                }
                result(.failure(APIErrors.transportError("Http get failed.")))
                return
            }
            
            switch self.checkResponse(response: response, data: data){
                case .failure(let error):
                    result(.failure(error))
                    return
                case .success(let data):
                    result(.success(data))
                    return
            }
            
        }
        dataTask.resume()
    }
    
    private func checkResponse(response: URLResponse?, data: Data?) -> Result<Data, APIErrors> {
        
        guard let urlResponse = response as? HTTPURLResponse else {
            return .failure(APIErrors.invalidResponseError)
        }

        if (200..<300) ~=  urlResponse.statusCode {
            print(urlResponse.statusCode)
            guard let data = data else { return .failure(APIErrors.validationError("Unable to decode api error.")) }
            return .success(data)
        }
        else {
            guard let data = data else { return .failure(APIErrors.validationError("Unable to decode api error.")) }
            
            let decoder = JSONDecoder()
            do {
                let apiError = try decoder.decode(APIErrorMessage.self, from: data)
                
                if (400..<499) ~=  urlResponse.statusCode {
                    return .failure(APIErrors.validationError("Failed with status code:  \(urlResponse.statusCode).  Reason: \(apiError.reason)"))
                }
                
                if 500 <= urlResponse.statusCode {
                    return .failure(APIErrors.validationError("Failed with status code:  \(urlResponse.statusCode).  Reason: \(apiError.reason)"))
                }
                
            } catch {
                return .failure(APIErrors.validationError("Unable to decode api error."))
            }
        }
        return .failure(APIErrors.invalidResponseError)
    }
}

//MARK: Conform the protocol
extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocol.DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
