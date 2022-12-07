//
//  DataService.swift
//  Workday
//
//  Created by Franco Fantillo on 2022-12-03.
//

import Foundation

enum Endpoint: String {
    case search = "/search"
}

protocol DataServiceProtocol {
    func getNasaData(searchString: String) async throws -> NasaCollection
}

struct APIErrorMessage: Decodable {
  var error: Bool
  var reason: String
}

enum APIError: LocalizedError {
  /// Invalid request, e.g. invalid URL
  case invalidRequestError(String)
  
  /// Indicates an error on the transport layer, e.g. not being able to connect to the server
  case transportError(Error)
    

    case invalidResponse
    
    case validationError(String)
}

class DataService: DataServiceProtocol {
    
    func getNasaData(searchString: String) async throws -> NasaCollection {
        
        let components = constructURL(searchValue: searchString)

        guard let url = components.url else {
            throw APIErrors.apiError
        }
    
        return try await getNextPage(nextURL: url)
    }
    
    func getNextPage(nextURL: URL) async throws -> NasaCollection {
        
        let (data, response) = try await URLSession.shared.data(from: nextURL)
        
        try checkResponse(response: response, data: data)
        print(data.prettyPrintedJSONString)

        let collection = try JSONDecoder().decode(NasaCollection.self, from: data)

        return collection
    }
    
    private func constructURL(searchValue: String) -> URLComponents{
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "images-api.nasa.gov"
        components.path = "/search"
        components.queryItems = [
            URLQueryItem(name: "q", value: searchValue),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "media_type", value: "image")
        ]
        return components
    }
    
    private func checkResponse(response: URLResponse, data: Data) throws {
        
        guard let urlResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        if (200..<300) ~=  urlResponse.statusCode {
            return
        }
        else {
            let decoder = JSONDecoder()
            let apiError = try decoder.decode(APIErrorMessage.self, from: data)

            if urlResponse.statusCode == 400 {
                throw APIError.validationError(apiError.reason)
            }
        }
    }
}
