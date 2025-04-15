//
//  AuthProvider.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/14/25.
//

import Foundation

public enum AuthProvider: String, CaseIterable, Codable {
    case email = "EMAIL"
    case google = "GOOGLE"
    case apple = "APPLE"
}
