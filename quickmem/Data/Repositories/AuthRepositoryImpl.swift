//
//  AuthRepositoryImpl.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/14/25.
//

import Foundation

class AuthRepositoryImpl: AuthRepository {
    private let remoteDataSource: QMAPIService

    init(remoteDataSource: QMAPIService) {
        self.remoteDataSource = remoteDataSource
    }
    
    func loginWithEmail(loginRequest: LoginRequestEntity) async throws -> AuthResponseEntity {
        do {
            let dto = LoginRequestDTO.fromDomain(entity: loginRequest)
            
            let response = try await remoteDataSource.loginWithEmail(loginRequest: dto)
            return response.toDomain()
        } catch {
            throw error
        }
    }

}
