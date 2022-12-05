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
    
    private func getNasaItems(){
        Task {
            do {
                let service = DataService()
                let collection = try await service.getNasaData(searchString: searchString)
                nasaItems.items = collection.items
            } catch let error as APIErrors {
                errorHandling.handle(error: error)
            }
        }
    }
    
    var body: some View {
        VStack {
            
            SearchBar(text: $searchString, focusBinding: $focus, onEditMethod: getNasaItems)
            List {
                ForEach(nasaItems.items) { item in
                   
                   InvoiceCell(invoice: invoice.wrappedValue)
                        .background(NavigationLink("", value: Route.invoiceOverview(ObservableInvoice(invoice: invoice.wrappedValue), false)).opacity(0))
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
