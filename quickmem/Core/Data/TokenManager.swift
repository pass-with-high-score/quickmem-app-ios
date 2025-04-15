//
//  TokenManager.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/15/25.
//

import KeychainAccess

actor TokenManager {
    static let shared = TokenManager()
    private let keychain = Keychain(service: "com.quickmem.app")

    var accessToken: String? {
        try? keychain.get("accessToken")
    }

    var refreshToken: String? {
        try? keychain.get("refreshToken")
    }

    func updateTokens(access: String, refresh: String) {
        try? keychain.set(access, key: "accessToken")
        try? keychain.set(refresh, key: "refreshToken")
    }

    func clearTokens() {
        try? keychain.remove("accessToken")
        try? keychain.remove("refreshToken")
    }
}
