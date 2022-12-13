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
    //func getNasaData(searchString: String) async throws -> NasaCollection
}

class DataService: DataServiceProtocol {

    let client: HttpClient
    
    init(client: HttpClient) {
        self.client = client
    }
    
    func getCollectionData(nextURL: URL, completion: @escaping (_ inner: () throws -> (NasaCollection)) -> ()) {
        
        client.getData(url: nextURL, result: { result in
            
            completion({
                switch result {
                case .success(let data):
                    print(data.prettyPrintedJSONString)
                    let collection = try JSONDecoder().decode(NasaCollection.self, from: data)
                    return collection
                case .failure(let error):
                    throw APIErrors.validationError(error.localizedDescription)
                }
            })
        })
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
