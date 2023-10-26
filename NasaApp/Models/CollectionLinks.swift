//
//  CollectionLinks.swift
//  NasaApp
//
//  Created by Franco Fantillo 
//

import Foundation

struct CollectonLinks: Codable {
    
    let href: String
    let prompt: String
    let rel: String
    
    enum CodingKeys: CodingKey {
        case rel
        case href
        case prompt
    }
    
    init(href: String, prompt: String, rel: String) {
        self.rel = rel
        self.prompt = prompt
        self.href = href
    }
    
    init(from decoder: Decoder) throws {
        // unload the top level?
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let href = try container.decode(String.self, forKey: .href)
        let rel = try container.decode(String.self, forKey: .rel)
        let prompt = try container.decode(String.self, forKey: .prompt)
        self.init(href: href, prompt: prompt, rel: rel)
    }
}
