//
//  RefreshRequestEntity.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/15/25.
//

import Foundation

public struct RefreshRequestEntity {
    let refreshToken: String
    
    init(refreshToken: String) {
        self.refreshToken = refreshToken
    }
}
