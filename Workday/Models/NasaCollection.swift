//
//  NasaCollection.swift
//  Workday
//
//  Created by Franco Fantillo on 2022-12-03.
//

import Foundation

struct NasaCollection: Decodable {

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
    
    init(href: String, links: [CollectonLinks]?, items: [NasaItem]) {
        self.href = href
        self.links = links
        self.items = items
    }
    
    init(from decoder: Decoder) throws {
        // unload the top level
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let collectionContainer = try container.nestedContainer(keyedBy: CollectionKeys.self, forKey: .collection)
        let href = try collectionContainer.decode(String.self, forKey: .href)
        let links = try collectionContainer.decodeIfPresent([CollectonLinks].self, forKey: .links)
        let items = try collectionContainer.decode([NasaItem].self, forKey: .items)
        self.init(href: href, links: links, items: items)
    }
}
