//
//  NasaLinks.swift
//  NasaApp
//
//  Created by Franco Fantillo
//

import Foundation

struct NasaLinks: Codable {
    
    enum CodingKeys: CodingKey {
        case rel
        case href
        case render
    }
    
    let href: String
    let rel: String
    let render: String
    
    init(href: String, render: String, rel: String) {
        self.rel = rel
        self.render = render
        self.href = href
    }
    
    init(from decoder: Decoder) throws {
        // unload the top level
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let href = try container.decode(String.self, forKey: .href)
        let rel = try container.decode(String.self, forKey: .rel)
        let render = try container.decode(String.self, forKey: .render)
        self.init(href: href, render: render, rel: rel)
    }
}
