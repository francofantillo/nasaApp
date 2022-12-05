//
//  Errors.swift
//  Invoicer
//
//  Created by Franco Fantillo on 2022-09-07.
//

import Foundation

enum APIErrors: Error {
    case apiError
}

extension APIErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .apiError:
            return NSLocalizedString("Encountered an api error.", comment: "api error.")
        }
    }
}
