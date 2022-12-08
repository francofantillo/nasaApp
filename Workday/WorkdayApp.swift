//
//  WorkdayApp.swift
//  Workday
//
//  Created by Franco Fantillo on 2022-12-02.
//

import SwiftUI

@main
struct WorkdayApp: App {
    
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
