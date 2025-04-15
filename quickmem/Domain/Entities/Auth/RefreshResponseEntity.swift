//
//  RefreshTokenResponseEntity.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/15/25.
//

public struct RefreshResponseEntity {
    let accessToken: String
    let refreshToken: String
    
    init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}
