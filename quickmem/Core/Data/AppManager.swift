//
//  AppManager.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/16/25.
//

import Foundation

actor AppManager {
    static let shared = AppManager()
    
    private enum AppKeychainKey {
        static let isLoggedIn = "isLoggedIn"
        static let onboarded = "onboarded"
        static let userId = "userId"
        static let email = "email"
        static let fullName = "fullName"
        static let username = "username"
    }
    
    private let userDefaults = UserDefaults.standard

    // MARK: - Login State
    func setUserLoggedIn(_ isLoggedIn: Bool) {
        userDefaults.set(isLoggedIn, forKey: AppKeychainKey.isLoggedIn)
    }
    
    func isUserLoggedIn() -> Bool {
        return userDefaults.bool(forKey: AppKeychainKey.isLoggedIn)
    }
    
    // MARK: - Onboarding State
    func setOnboardedStatus(_ status: Bool) {
        userDefaults.set(status, forKey: AppKeychainKey.onboarded)
    }

    func getOnboardedStatus() -> Bool {
        return userDefaults.bool(forKey: AppKeychainKey.onboarded)
    }

    // MARK: - User Info
    func setUserId(_ id: String) {
        userDefaults.set(id, forKey: AppKeychainKey.userId)
    }

    func getUserId() -> String? {
        return userDefaults.string(forKey: AppKeychainKey.userId)
    }

    func setEmail(_ email: String) {
        userDefaults.set(email, forKey: AppKeychainKey.email)
    }

    func getEmail() -> String? {
        return userDefaults.string(forKey: AppKeychainKey.email)
    }

    func setFullName(_ name: String) {
        userDefaults.set(name, forKey: AppKeychainKey.fullName)
    }

    func getFullName() -> String? {
        return userDefaults.string(forKey: AppKeychainKey.fullName)
    }

    func setUsername(_ username: String) {
        userDefaults.set(username, forKey: AppKeychainKey.username)
    }

    func getUsername() -> String? {
        return userDefaults.string(forKey: AppKeychainKey.username)
    }

    // MARK: - Clear All User Data
    func clearUserData() {
        userDefaults.removeObject(forKey: AppKeychainKey.isLoggedIn)
        userDefaults.removeObject(forKey: AppKeychainKey.onboarded)
        userDefaults.removeObject(forKey: AppKeychainKey.userId)
        userDefaults.removeObject(forKey: AppKeychainKey.email)
        userDefaults.removeObject(forKey: AppKeychainKey.fullName)
        userDefaults.removeObject(forKey: AppKeychainKey.username)
    }
}
