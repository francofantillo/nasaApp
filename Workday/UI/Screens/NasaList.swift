//
//  ContentView.swift
//  Workday
//
//  Created by Franco Fantillo on 2022-12-02.
//

import Combine
import SwiftUI

struct NasaList: View {
    
    @EnvironmentObject private var errorHandling: ErrorHandling
    @StateObject var nasaItems = NasaItems(items: [])
    @State var searchString = ""
    @FocusState var focus
    @State var nextPageLink: String = ""
    
    var searchStringBinding: Binding<String> { Binding (

        get: {
            return self.searchString
        },

        set: {
            guard $0 != "" else {
                nasaItems.items = []
                self.searchString = $0
                nextPageLink = ""
                return
            }
            guard self.searchString != $0 else { return }
            self.searchString = $0
            self.getNasaItems(searchString: $0)
        })
    }
    
    private func getNextPage(){
        Task {
            do {
                let service = DataService()
                guard let url = URL(string: nextPageLink) else {
                    throw APIError.invalidResponse
                }
                let collection = try await service.getNextPage(nextURL: url)
                DispatchQueue.main.async {
                    nasaItems.items.append(contentsOf: collection.items)
                    guard let links = collection.links else { return }
                    for link in links {
                        if link.rel == "next" {
                            nextPageLink = link.href
                            nextPageLink = nextPageLink.replace(target: "http", withString:"https")
                        }
                    }
                }
            } catch let error as APIErrors {
                errorHandling.handle(error: error)
            }
            catch let error {
                errorHandling.handle(error: error)
            }
        }
    }
    
    private func getNasaItems(searchString: String){
        Task {
            do {
                let service = DataService()
                let collection = try await service.getNasaData(searchString: searchString)
                DispatchQueue.main.async {
                    nasaItems.items = collection.items
                    guard let links = collection.links else { return }
                    for link in links {
                        if link.rel == "next" {
                            nextPageLink = link.href
                            nextPageLink = nextPageLink.replace(target: "http", withString:"https")
                        }
                    }
                }
            } catch let error as APIErrors {
                errorHandling.handle(error: error)
            }
            catch let error {
                errorHandling.handle(error: error)
            }
        }
    }
    
    private func getDetailsVM(item: NasaItem) -> DetailScreen.DetailScreenViewModel {
        
        let vm = DetailScreen.DetailScreenViewModel(title: item.data[0].title ?? "",
                                                imageURL: item.links[0].href,
                                                description:item.data[0].description ?? "" ,
                                                    date: item.data[0].date_created)
        return vm
    }
    
    var body: some View {
        VStack {
            
            SearchBar(text: searchStringBinding, focusBinding: $focus, onEditMethod: nil)
                .padding(22)
            if !nasaItems.items.isEmpty {
                List {
                    ForEach(nasaItems.items) { item in
                        
                        if let data = item.data {
                            
                            
                            NasaCell(vm: NasaCell.NasaCellViewModel(title: data[0].title ?? "" , imageURL: item.links[0].href, description: data[0].description ?? "", dateCreated:   data[0].date_created ))
                            
                                .padding([.leading, .trailing],-16)
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .buttonStyle(PlainButtonStyle())
                                .onAppear(){
                                    if nasaItems.items.last == item {
                                        getNextPage()
                                    }
                                }
                        }
                    }
                    
                    ProgressView()
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .buttonStyle(PlainButtonStyle())
                }
                .scrollContentBackground(.hidden)
                .listStyle(PlainListStyle())
                .padding([.leading, .trailing])
                 
            }
            Spacer()
        }
        .padding()
        .background(Color("Primary"))
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Nasa Search")
        .navigationBarTitleDisplayMode(.large)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NasaList()
    }
}
