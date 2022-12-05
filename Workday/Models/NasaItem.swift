//
//  NasaItem.swift
//  Workday
//
//  Created by Franco Fantillo on 2022-12-03.
//

import Foundation

struct NasaItem: Decodable {
    
    let data: [NasaData]
    let href: String
    let links: [NasaLinks]
}
