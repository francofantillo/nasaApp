//
//  ContentView.swift
//  Workday
//
//  Created by Franco Fantillo on 2022-12-02.
//

import Combine
import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var errorHandling: ErrorHandling
    @StateObject var nasaItems = NasaItems(items: [])
    @State var searchString = ""
    @FocusState var focus
    
    var searchStringBinding: Binding<String> { Binding (

        get: {
            return self.searchString
        },

        set: {
            guard $0 != "" else {
                nasaItems.items = []
                self.searchString = $0
                return
            }
            guard self.searchString != $0 else { return }
            self.searchString = $0
            self.getNasaItems(searchString: $0)
        })
    }
    
    private func getNasaItems(searchString: String){
        Task {
            do {
                let service = DataService()
                let collection = try await service.getNasaData(searchString: searchString)
                DispatchQueue.main.async {
                    nasaItems.items = collection.items
                }
            } catch let error as APIErrors {
                errorHandling.handle(error: error)
            }
            catch let error {
                errorHandling.handle(error: error)
            }
        }
    }
    
    var body: some View {
        VStack {
            
            SearchBar(text: searchStringBinding, focusBinding: $focus, onEditMethod: nil)
            List {
                ForEach(nasaItems.items) { item in
                   
                    NasaCell(vm: NasaCell.NasaCellViewModel(title: item.data[0].title, imageURL: item.links[0].href, description: item.data[0].description, dateCreated:   item.data[0].date_created))
                   .padding([.leading, .trailing],-16)
                   .listRowBackground(Color.clear)
                   .listRowSeparator(.hidden)
                   .buttonStyle(PlainButtonStyle())
               }
               
           }
           .scrollContentBackground(.hidden)
           .listStyle(PlainListStyle())
           .padding([.leading, .trailing])
            Spacer()
           
        }
        .padding()
        .background(Color("Primary"))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
