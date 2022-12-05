//
//  DataService.swift
//  Workday
//
//  Created by Franco Fantillo on 2022-12-02.
//

import Foundation
import Combine
import Foundation
import SwiftUI



//class DataServiceCombine {
//
//    func getNasaData(userName: String) -> AnyPublisher<NasaCollection, Error> {
//
//        var components = URLComponents()
//        components.scheme = "https"
//        components.host = "images-api.nasa.gov"
//        components.path = "/search"
//        components.queryItems = [
//            URLQueryItem(name: "q", value: "apollo"),
//            URLQueryItem(name: "page", value: "1")
//        ]
//
//        guard let url = components.url else {
//         return Fail(error: APIError.invalidRequestError("URL invalid"))
//           .eraseToAnyPublisher()
//        }
//
//        return URLSession.shared.dataTaskPublisher(for: url)
//        // handle URL errors (most likely not able to connect to the server)
//        .mapError { error -> Error in
//        return APIError.transportError(error)
//        }
//
//        // handle all other errors
//        .tryMap { (data, response) -> (data: Data, response: URLResponse) in
//            print("Received response from server, now checking status code")
//
//            guard let urlResponse = response as? HTTPURLResponse else {
//                throw APIError.invalidResponse
//            }
//
//            if (200..<300) ~=  urlResponse.statusCode {
//
//            }
//            else {
//                let decoder = JSONDecoder()
//                let apiError = try decoder.decode(APIErrorMessage.self,
//                                                     from: data)
//
//                if urlResponse.statusCode == 400 {
//                  throw APIError.validationError(apiError.reason)
//                }
//            }
//            return (data, response)
//        }
//
//        .map(\.data)
//        .decode(type: NasaCollection.self, decoder: JSONDecoder())
//        .eraseToAnyPublisher()
//    }
//
//    func getNasaData() -> AnyPublisher<String, APIErrors> {
//
//        var components = URLComponents()
//        components.scheme = "https"
//        components.host = "images-api.nasa.gov"
//        components.path = "/search"
//        components.queryItems = [
//            URLQueryItem(name: "q", value: "apollo")
//        ]
//
//        guard let url = components.url else {
//            return Just(APIErrors.apiError).eraseToAnyPublisher()
//        }
//
//        return URLSession.shared.dataTaskPublisher(for: url)
//          .map { data, response in
//            do {
//              let decoder = JSONDecoder()
//
//                let str = String(decoding: data, as: UTF8.self)
//
//                print(data.prettyPrintedJSONString)
//              return str
//            }
////            catch {
////              return "false"
////            }
//          }
//          .replaceError(with: APIErrors.self)
//          .eraseToAnyPublisher()
//
//    }
//}

//class MockDataService: DataServiceProtocol {
//
//    let mock = Just("Test string")
//        .setFailureType(to: Never.self)
//        .eraseToAnyPublisher()
//
//    func getNasaData() -> AnyPublisher<String, APIErrors> {
//
//        return mock
//    }
//
//}


