//
//  DetailScreenViewModel.swift
//  Workday
//
//  Created by Franco Fantillo 
//

import Foundation

extension DetailScreen {
    
    class DetailScreenViewModel: ObservableObject {
        
        init(title: String, imageURL: String, description: String, date: String) {
            self.title = title
            self.imageURL = imageURL
            self.description = description
            self.date = date
        }
        
        let title: String
        let imageURL: String
        let description: String
        let date: String
    }
}
