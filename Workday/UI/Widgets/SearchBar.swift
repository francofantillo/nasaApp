//
//  SearchBar.swift
//  Invoicer
//
//  Created by Franco Fantillo on 2022-09-05.
//

import SwiftUI
import Foundation

struct SearchBar: View {
    
    @State private var isEditing = false
    @Binding var text: String
    private var onEditMethod: (() -> Void)?
    
    init(text: Binding<String>, onEditMethod: (() -> Void)?) {
        self._text = text
        self.onEditMethod = onEditMethod
    }
 
    var body: some View {
        HStack {
 
            TextField("Search ...", text: $text, onEditingChanged: { _ in
                guard let closure = onEditMethod else { return }
                closure()
            })
            .placeholder(when: text.isEmpty, placeholder: {
                Text("Search ...").foregroundColor(Color(UIColor.gray.cgColor))
            })
            .submitLabel(.done)
            .padding(7)
            .padding(.horizontal, 25)
            .foregroundColor(Color("DarkGray"))
            .background(Color("LightGray"))

            .cornerRadius(8)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
             
                    if isEditing {
                        Button(action: {
                            self.text = ""
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }
                    }
                }
            )

            .onTapGesture {
                self.isEditing = true
            }

        }
    }
}

//struct SearchBar_Previews: PreviewProvider {
//
//    static var previews: some View {
//
//        var bool = FocusState()
//        ZStack {
//            SearchBar(text: Binding<String>.constant("search"))
//        }
//    }
//}
