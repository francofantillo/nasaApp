//
//  NasaItems.swift
//  Workday
//
//  Created by Franco Fantillo on 2022-12-04.
//

import Foundation

class NasaItems: ObservableObject {
    
    @Published var items: [NasaItem]
    
    init(items: [NasaItem]) {
        self.items = items
    }
}
