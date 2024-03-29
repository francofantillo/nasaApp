//
//  ContentView.swift
//  NasaApp
//
//  Created by Franco Fantillo 
//

import SwiftUI

struct NasaList: View {
    
    @StateObject private var viewModel: NasaListViewModel = NasaListViewModel(service: DataService(client: HttpClient(session: URLSession.shared)))
    @EnvironmentObject private var errorHandling: ErrorHandling
    let config = UIConfig()
    
    var searchStringBinding: Binding<String> { Binding (

        get: {
            return self.viewModel.searchString
        },

        set: {
            guard $0 != "" else {
                viewModel.items = []
                self.viewModel.searchString = $0
                viewModel.nextPageLink = ""
                return
            }
            guard self.viewModel.searchString != $0 else { return }
            self.viewModel.searchString = $0
            viewModel.nextPageLink = ""
            getNasaItems(text: $0)
        })
    }
    
    private func getNasaItems(text: String){
        viewModel.cancelTask()
        viewModel.nasaTask = Task {
            do {
                try await self.viewModel.getNasaItems(searchString: text)
            } catch let error as APIErrors {
                errorHandling.handleApiError(error: error)
            }
            catch let error {
                errorHandling.handle(error: error)
            }
        }
    }
    
    private func getNextPage() {
        viewModel.cancelTask()
        viewModel.nasaTask = Task {
            do {
                try await viewModel.getNextPage()
            } catch let error as APIErrors {
                errorHandling.handleApiError(error: error)
            }
            catch let error {
                errorHandling.handle(error: error)
            }
        }
    }

    var body: some View {
        VStack {
            
            SearchBar(text: searchStringBinding, onEditMethod: nil)
                .padding(config.quarterPadding)
                
            if !viewModel.items.isEmpty {
                List {
                    ForEach(viewModel.items) { item in
                        
                        let data = item.data
                        NasaCell(vm: NasaCell.NasaCellViewModel(title: data[0].title ?? "", imageURL: item.links[0].href, description: data[0].description ?? "", dateCreated:   data[0].date_created ))
                        
                            .padding([.leading, .trailing],-config.padding)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .buttonStyle(PlainButtonStyle())
                            .onAppear(){
                                if viewModel.items.last == item {
                                    getNextPage()
                                }
                            }
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(PlainListStyle())
                .padding([.leading, .trailing], .zero)
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
