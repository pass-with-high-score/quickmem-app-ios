//
//  AuthResponseEntity.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/14/25.
//

import Foundation

struct AuthResponseDTO: Codable {
    let accessToken: String
    let avatarUrl: String
    let bannedAt: String?
    let bannedReason: String?
    let birthday: String?
    let coin: Int
    let email: String
    let fullName: String
    let id: String
    let isPremium: Bool
    let isVerified: Bool
    let provider: [String]
    let refreshToken: String
    let username: String
    let userStatus: String
    
    func toDomain() -> AuthResponseEntity {
        return AuthResponseEntity(
            accessToken: accessToken,
            avatarUrl: avatarUrl,
            bannedAt: bannedAt,
            bannedReason: bannedReason,
            birthday: birthday,
            coin: coin,
            email: email,
            fullName: fullName,
            id: id,
            isPremium: isPremium,
            isVerified: isVerified,
            provider: provider,
            refreshToken: refreshToken,
            username: username,
            userStatus: userStatus
        )
    }
    
    
    static func fromDomain(entity: AuthResponseEntity) -> AuthResponseDTO {
        return AuthResponseDTO(
            accessToken: entity.accessToken,
            avatarUrl: entity.avatarUrl,
            bannedAt: entity.bannedAt,
            bannedReason: entity.bannedReason,
            birthday: entity.birthday,
            coin: entity.coin,
            email: entity.email,
            fullName: entity.fullName,
            id: entity.id,
            isPremium: entity.isPremium,
            isVerified: entity.isVerified,
            provider: entity.provider,
            refreshToken: entity.refreshToken,
            username: entity.username,
            userStatus: entity.userStatus
        )
    }
}
