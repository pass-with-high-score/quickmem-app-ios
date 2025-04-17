//
//  APIError.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/14/25.
//

import Foundation

enum APIError: Error, LocalizedError {
    case unauthorized
    case clientError(statusCode: Int, message: String?)
    case serverError(statusCode: Int)
    case invalidResponse
    case unknown

    var errorDescription: String? {
        switch self {
        case .unauthorized:
            return "Unauthorized access"
        case .clientError(_, let message):
            return message ?? "Client Error"
        case .serverError:
            return "Server Error"
        case .invalidResponse:
            return "Invalid Response"
        case .unknown:
            return "Unknown Error"
        }
    }
}
