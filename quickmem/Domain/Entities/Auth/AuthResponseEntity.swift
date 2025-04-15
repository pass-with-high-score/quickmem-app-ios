//
//  AuthResponseEntity.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/14/25.
//

import Foundation

struct AuthResponseEntity {
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
}
