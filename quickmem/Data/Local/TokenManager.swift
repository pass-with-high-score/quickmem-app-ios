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

    private enum AppKeychainKey {
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
    }

    var accessToken: String? {
        try? keychain.get(AppKeychainKey.accessToken)
    }

    var refreshToken: String? {
        try? keychain.get(AppKeychainKey.refreshToken)
    }

    func updateTokens(access: String, refresh: String) {
        try? keychain.set(access, key: AppKeychainKey.accessToken)
        try? keychain.set(refresh, key: AppKeychainKey.refreshToken)
    }

    func clearTokens() {
        try? keychain.remove(AppKeychainKey.accessToken)
        try? keychain.remove(AppKeychainKey.refreshToken)
    }
}
