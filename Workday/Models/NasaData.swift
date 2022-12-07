//
//  NasaData.swift
//  Workday
//
//  Created by Franco Fantillo on 2022-12-03.
//

import Foundation

struct NasaData: Codable {
    
    enum CodingKeys: CodingKey {
        case center
        case date_created
        case description
        case keywords
        case media_type
        case nasa_id
        case title
    }
    
    let center: String
    let date_created: String
    let description: String?
    let keywords: [String]
    let media_type: String
    let nasa_id: String
    let title: String
    
    init(center: String, date_created: String, description: String?, keywords: [String], media_type: String, nasa_id: String, title: String) {
        self.center = center
        self.date_created = date_created
        self.description = description
        self.keywords = keywords
        self.media_type = media_type
        self.nasa_id = nasa_id
        self.title = title
    }
    
    init(from decoder: Decoder) throws {
        // unload the top level
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let center = try container.decode(String.self, forKey: .center)
        let date = try container.decode(String.self, forKey: .date_created)
        let description = try container.decodeIfPresent(String.self, forKey: .description)
        let keywords = try container.decode([String].self, forKey: .keywords)
        let media_type = try container.decode(String.self, forKey: .media_type)
        let nasa_id = try container.decode(String.self, forKey: .nasa_id)
        let title = try container.decode(String.self, forKey: .title)
        self.init(center: center, date_created: date, description: description, keywords: keywords, media_type: media_type, nasa_id: nasa_id, title: title)
        
    }
}
