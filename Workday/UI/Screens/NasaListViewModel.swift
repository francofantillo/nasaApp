//
//  NasaListViewModel.swift
//  Workday
//
//  Created by Franco Fantillo on 2023-05-13.
//

import Foundation

extension NasaList {
    
    class NasaListViewModel: ObservableObject {
        
        @Published var items: [NasaItem] = [NasaItem]()
        @Published var searchString = ""
        @Published var nextPageLink: String = ""
        let service = DataService(client: HttpClient(session: URLSession.shared))
        
        private func appendNewData(collection: NasaCollection){
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.items.append(contentsOf: collection.items)
                self.handleNextLinks(collection: collection)
            }
        }
        
        private func setNewdata(collection: NasaCollection){
            DispatchQueue.main.async  { [weak self] in
                guard let self = self else { return }
                self.items = collection.items
                self.handleNextLinks(collection: collection)
            }
        }
        
        private func handleNextLinks(collection: NasaCollection){
            
            guard let links = collection.links else { return }
            
            guard !links.isEmpty else {
                nextPageLink = ""
                return
            }
            
            for link in links {
                if link.rel == "next" {
                    nextPageLink = link.href
                    nextPageLink = nextPageLink.replace(target: "http", withString:"https")
                }
                if link.rel == "prev" && links.count == 1 {
                    nextPageLink = ""
                }
            }
        }
        
        func getNextPage() async throws {

            guard nextPageLink != "" else { return }
            let url = try service.constructURLFromString(urlString: nextPageLink)
            let collection = try await service.getCollectionData(nextURL: url)
            appendNewData(collection: collection)
        }
        
        func getNasaItems(searchString: String) async throws {
            
            let url = try service.constructURLFromComponents(searchValue: searchString)
            let collection = try await service.getCollectionData(nextURL: url)
            setNewdata(collection: collection)
        }
    }
}
