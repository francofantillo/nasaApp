//
//  NasaItem.swift
//  Workday
//
//  Created by Franco Fantillo on 2022-12-03.
//

import Foundation

struct NasaItem: Decodable, Identifiable {
    
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
    
    init(from decoder: Decoder) throws {
        // unload the top level
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.decode([NasaData].self, forKey: .data)
        let href = try container.decode(String.self, forKey: .href)
        let links = try container.decode([NasaLinks].self, forKey: .links)
        self.init(data: data, href: href, links: links)
    }
}
