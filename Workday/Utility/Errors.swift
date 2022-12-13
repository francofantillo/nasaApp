//
//  Errors.swift
//  Invoicer
//
//  Created by Franco Fantillo on 2022-09-07.
//

import Foundation

struct APIErrorMessage: Decodable {
  var error: Bool
  var reason: String
}

enum APIErrors: Error {
    /// Invalid request, e.g. invalid URL
      case invalidRequestError
    /// Indicates an error on the transport layer, e.g. not being able to connect to the server
      case transportError(String)
    ///The resoonse was not in a usable format.
      case invalidResponseError
    ///Server returned an improper status code
      case validationError(String)
}

extension APIErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidRequestError:
            return NSLocalizedString("Request was not valid.", comment: "Request error.")
        case .transportError(let errorMessage):
            return NSLocalizedString("Communication with server failed with error: \(errorMessage)", comment: "Transport error.")
        case .invalidResponseError:
            return NSLocalizedString("The reponse was not valid", comment: "Response error.")
        case .validationError(let errorMessage):
            return NSLocalizedString(errorMessage, comment: "Validation error.")
        }
    }
}
