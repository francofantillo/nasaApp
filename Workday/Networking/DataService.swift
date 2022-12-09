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

class DataService: DataServiceProtocol {
    
    func getNasaData(searchString: String) async throws -> NasaCollection {
        
        let components = constructURL(searchValue: searchString)

        guard let url = components.url else {
            throw APIErrors.invalidRequestError
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
    
    func constructURLFromString(urlString: String) throws -> URL {
        guard let url = URL(string: urlString) else {
            throw APIErrors.invalidRequestError
        }
        return url
    }
    
    private func checkResponse(response: URLResponse, data: Data) throws {
        
        guard let urlResponse = response as? HTTPURLResponse else {
            throw APIErrors.invalidResponseError
        }

        if (200..<300) ~=  urlResponse.statusCode {
            return
        }
        else {
            let decoder = JSONDecoder()
            let apiError = try decoder.decode(APIErrorMessage.self, from: data)

            if (400..<499) ~=  urlResponse.statusCode {
                throw APIErrors.validationError(apiError.reason)
            }
            
            if 500 < urlResponse.statusCode {
                throw APIErrors.validationError(apiError.reason)
            }
        }
    }
}
