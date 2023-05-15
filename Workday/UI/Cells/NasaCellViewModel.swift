//
//  InvoiceCellViewModel.swift
//  Invoicer
//
//  Created by Franco Fantillo 
//

import Foundation

extension NasaCell {
    
    class NasaCellViewModel {
        
        let title: String
        let imageURL: String
        let description: String?
        let dateCreated: String
        
        init(title: String, imageURL: String, description: String?, dateCreated: String) {
            self.title = title
            self.imageURL = imageURL
            self.description = description
            self.dateCreated = dateCreated
        }
    }
}
