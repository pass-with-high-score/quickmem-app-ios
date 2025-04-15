//
//  LoginRequestDTO.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/14/25.
//

import Foundation

struct LoginRequestDTO: Codable {
    let email: String
    let password: String
    let provider: AuthProvider

    public init(email: String, password: String, provider: AuthProvider) {
        self.email = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        self.password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        self.provider = provider
    }

    func toDomain() -> LoginRequestEntity {
        return LoginRequestEntity(
            email: email,
            password: password,
            provider: provider
        )
    }

    static func fromDomain(entity: LoginRequestEntity) -> LoginRequestDTO {
        return LoginRequestDTO(
            email: entity.email,
            password: entity.password,
            provider: entity.provider
        )
    }
}
