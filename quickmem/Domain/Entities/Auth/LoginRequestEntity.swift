//
//  Untitled.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/14/25.
//

import Foundation


public struct LoginRequestEntity {
    public let email: String
    public let password: String
    public let provider: AuthProvider

    public init(email: String, password: String, provider: AuthProvider) {
        self.email = email
        self.password = password
        self.provider = provider
    }
}

