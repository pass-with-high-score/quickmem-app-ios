//
//  DataManager.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/12/25.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    func saveOnboardedStatus(_ isOnboarded: Bool) {
        defaults.set(isOnboarded, forKey: UserDefaultsKey.isOnboarded.key)
    }
    
    
    func getOnboardedStatus() -> Bool? {
        return defaults.bool(forKey: UserDefaultsKey.isOnboarded.key)
    }
    
    func clearUserData() {
        defaults.removeObject(forKey: UserDefaultsKey.isOnboarded.key)
    }
}
