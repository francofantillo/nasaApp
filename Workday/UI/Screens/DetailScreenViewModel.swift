//
//  DetailScreenViewModel.swift
//  Workday
//
//  Created by Franco Fantillo on 2022-12-08.
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
