//
//  APIError.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/14/25.
//

import Foundation

enum APIError: Error {
    case unauthorized
    case invalidResponse
    case clientError(statusCode: Int)
    case serverError(statusCode: Int)
    case unknown
}
