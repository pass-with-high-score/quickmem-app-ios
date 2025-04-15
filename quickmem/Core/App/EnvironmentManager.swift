//
//  EnvironmentManager.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/15/25.
//

import Foundation

class EnvironmentManager {

    // MARK: - Singleton to access this class globally
    static let shared = EnvironmentManager()

    private init() {}

    // MARK: - Set up environment variable
    func setUpEnvironment() {
        setenv("BASE_URL", "https://api.quickmem.app/", 1)
    }
    
    // MARK: - Retrieve the environment variable
    func getBaseURL() -> String {
        return ProcessInfo.processInfo.environment["BASE_URL"] ?? ""
    }
}
