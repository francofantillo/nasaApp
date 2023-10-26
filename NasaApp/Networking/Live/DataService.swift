//
//  DataService.swift
//  NasaApp
//
//  Created by Franco Fantillo
//

import Foundation

enum Endpoint: String {
    case search = "/search"
}

protocol DataServiceProtocol {
    //func getNasaData(searchString: String) async throws -> NasaCollection
}

class DataService: DataServiceProtocol {

    let client: HttpClient
    
    init(client: HttpClient) {
        self.client = client
    }
    
    func getCollectionData(nextURL: URL) async throws -> NasaCollection {
        
        let data = try await client.getData(url: nextURL)
        //print(data.prettyPrintedJSONString)
        let collection = try JSONDecoder().decode(NasaCollection.self, from: data)
        return collection
    }
    
    func constructURLFromString(urlString: String) throws -> URL {
        guard let url = URL(string: urlString) else {
            throw APIErrors.invalidRequestError
        }
        return url
    }

    func constructURLFromComponents(searchValue: String) throws -> URL {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "images-api.nasa.gov"
        components.path = "/search"
        components.queryItems = [
            URLQueryItem(name: "q", value: searchValue),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "media_type", value: "image")
        ]
        guard let url = components.url else {
            throw APIErrors.invalidRequestError
        }
        return url
    }
    

}
