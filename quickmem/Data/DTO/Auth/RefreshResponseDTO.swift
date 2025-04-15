//
//  RefreshTokenResponseDTO.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/15/25.
//

import Foundation

public struct RefreshResponseDTO: Codable {
    let accessToken: String
    let refreshToken: String

    func toDomain() -> RefreshResponseEntity {
        return RefreshResponseEntity(
            accessToken: accessToken, refreshToken: refreshToken)
    }
}
