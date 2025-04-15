//
//  ErrorResponse.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/15/25.
//

struct ErrorResponse: Codable {
    let message: [String]?
    let error: String?
    let statusCode: Int?
}
