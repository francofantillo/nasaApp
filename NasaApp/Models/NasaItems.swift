//
//  NasaItems.swift
//  NasaApp
//
//  Created by Franco Fantillo
//

import Foundation

class NasaItems: ObservableObject {
    
    @Published var items: [NasaItem]
    
    init(items: [NasaItem]) {
        self.items = items
    }
}
