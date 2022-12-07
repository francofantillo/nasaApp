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
    
    init(href: String, items: [NasaItem], links: [CollectonLinks]?) {
        
        self.href = href
        self.links = links
        self.items = items
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
