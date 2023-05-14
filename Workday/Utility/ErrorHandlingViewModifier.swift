//
//  ErrorHandlingViewModifier.swift
//  Invoicer
//
//  Created by Franco Fantillo on 2022-09-30.
//

import SwiftUI

struct ErrorAlert: Identifiable {
    var id = UUID()
    var message: String
    var dismissAction: (() -> Void)?
}

class ErrorHandling: ObservableObject {
    
    @Published var currentAlert: ErrorAlert?

    func handleApiError(error: APIErrors) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.currentAlert = ErrorAlert(message: error.errorDescription ?? "Unknown error.")
        }
    }
    
    func handle(error: Error) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.currentAlert = ErrorAlert(message: error.localizedDescription)
        }
    }
}

struct HandleErrorsByShowingAlertViewModifier: ViewModifier {
    @StateObject var errorHandling = ErrorHandling()

    func body(content: Content) -> some View {
        content
            .environmentObject(errorHandling)
            // Applying the alert for error handling using a background element
            // is a workaround, if the alert would be applied directly,
            // other .alert modifiers inside of content would not work anymore
            .background(
                EmptyView()
                    .alert(item: $errorHandling.currentAlert) { currentAlert in
                        Alert(
                            title: Text("Error"),
                            message: Text(currentAlert.message),
                            dismissButton: .default(Text("Ok")) {
                                currentAlert.dismissAction?()
                            }
                        )
                    }
            )
    }
}
