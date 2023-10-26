//
//  NasaAppApp.swift
//  NasaApp
//
//  Created by Franco Fantillo
//

import SwiftUI

@main
struct NasaApp: App {
    
    init(){
        
        UINavigationBar.appearance().titleTextAttributes = [ .foregroundColor: UIColor.white ]
        UINavigationBar.appearance().largeTitleTextAttributes = [ .foregroundColor: UIColor.white ]
        //UINavigationBar.appearance().backgroundColor = UIColor.lightGray
        
        
        UICollectionView.appearance().backgroundColor = .clear
        UITextField.appearance().keyboardAppearance = UIKeyboardAppearance.light

        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        
        UIScrollView.appearance().backgroundColor = .clear
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                NasaList()
                    .withErrorHandling()
                    .router()
            }
        }
    }
}
