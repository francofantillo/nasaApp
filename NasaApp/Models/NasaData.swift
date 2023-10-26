//
//  NasaData.swift
//  Workday
//
//  Created by Franco Fantillo
//

import Foundation

struct NasaData: Codable {
    
    enum CodingKeys: CodingKey {
        case date_created
        case description
        case title
    }
    
    let date_created: String
    let description: String?
    let title: String?
    
    init(date_created: String, description: String?, title: String?) {
        self.date_created = date_created
        self.description = description
        self.title = title
    }
    
    init(from decoder: Decoder) throws {
        // unload the top level
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let date = try container.decode(String.self, forKey: .date_created)
        let description = try container.decodeIfPresent(String.self, forKey: .description)
        let title = try container.decodeIfPresent(String.self, forKey: .title)
        self.init(date_created: date, description: description, title: title)
        
    }
}
