//
//  NasaCollection.swift
//  NasaApp
//
//  Created by Franco Fantillo
//

import Foundation

struct NasaCollection: Codable {

    enum CodingKeys: CodingKey {
        case collection
    }
    
    enum CollectionKeys: CodingKey {
        case href
        case links
        case items
    }
    
    let href: String
    let items: [NasaItem]
    let links: [CollectonLinks]?
    
    init(href: String, items: [NasaItem], links: [CollectonLinks]?) {
        
        self.href = href
        self.links = links
        self.items = items
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var collectionContainer = container.nestedContainer(keyedBy: CollectionKeys.self, forKey: .collection)
        try collectionContainer.encode(href, forKey: .href)
        try collectionContainer.encode(items, forKey: .items)
        try collectionContainer.encodeIfPresent(links, forKey: .links)
    }
    
    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        let collectionContainer = try container.nestedContainer(keyedBy: CollectionKeys.self, forKey: .collection)
        let href = try collectionContainer.decode(String.self, forKey: .href)
        let items = try collectionContainer.decode([NasaItem].self, forKey: .items)
        let links = try collectionContainer.decodeIfPresent([CollectonLinks].self, forKey: .links)
        self.init(href: href, items: items, links: links)
    }
}
