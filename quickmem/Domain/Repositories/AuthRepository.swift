//
//  AuthRepository.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/14/25.
//

import Foundation

protocol AuthRepository {
    func loginWithEmail(loginRequest: LoginRequestEntity) async throws -> AuthResponseEntity
}
