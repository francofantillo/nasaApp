//
//  Router.swift
//  Invoicer
//
//  Created by Franco Fantillo on 2022-10-17.
//

import SwiftUI

enum Route: Hashable {
    
    static func == (lhs: Route, rhs: Route) -> Bool {
        return false
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self)
    }
    
    case detailScreen(viewModel: DetailScreen.DetailScreenViewModel)
}

struct Router: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .detailScreen(let vm):
                    DetailScreen(vm: vm)
                }
            }
    }
}

extension View {
    func router() -> some View {
        modifier(Router())
    }
}
