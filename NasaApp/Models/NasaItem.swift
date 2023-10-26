//
//  NasaItem.swift
//  NasaApp
//
//  Created by Franco Fantillo 
//

import Foundation

struct NasaItem: Codable, Identifiable, Equatable {
    
    static func == (lhs: NasaItem, rhs: NasaItem) -> Bool {
        lhs.id == rhs.id
    }
    
    enum CodingKeys: CodingKey {
        case data
        case href
        case links
    }
    
    var id = UUID()
    let data: [NasaData]
    let href: String
    let links: [NasaLinks]
    
    init(data: [NasaData], href: String, links: [NasaLinks]) {
        self.data = data
        self.href = href
        self.links = links
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try container.encode(href, forKey: .href)
        try container.encode(links, forKey: .links)
    }
    
    init(from decoder: Decoder) throws {
        // unload the top level
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.decode([NasaData].self, forKey: .data)
        let href = try container.decode(String.self, forKey: .href)
        let links = try container.decode([NasaLinks].self, forKey: .links)
        self.init(data: data, href: href, links: links)
    }
}
