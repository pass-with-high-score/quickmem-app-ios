//
//  UserDefaultsKey.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/12/25.
//

import Foundation

enum UserDefaultsKey: String {
    case isOnboarded
    
    var key: String {
        return self.rawValue
    }
}
