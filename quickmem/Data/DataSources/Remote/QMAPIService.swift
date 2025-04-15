//
//  QMAPIClient.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/14/25.
//

protocol QMAPIService {
    func loginWithEmail(loginRequest: LoginRequestDTO) async throws -> AuthResponseDTO
    func refreshToken() async throws -> Void
}
