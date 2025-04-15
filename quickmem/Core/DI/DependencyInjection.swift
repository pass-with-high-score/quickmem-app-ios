//
//  DependencyInjection.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/15/25.
//

import Foundation

class DependencyInjection {
    
    
    // MARK: - Data Layer
    static func provideQMAPIService() -> QMAPIService {
        EnvironmentManager.shared.setUpEnvironment()
        let baseURL = EnvironmentManager.shared.getBaseURL()
        return QMAPIClient(baseURL: baseURL)
    }
    
    // MARK: - Domain Layer - Repositories
    static func provideAuthRepository() -> AuthRepository {
        return AuthRepositoryImpl(remoteDataSource: provideQMAPIService())
    }
    
    // MARK: - Presentation Layer - ViewModels
    static func provideLoginWithEmailViewModel() -> LoginWithEmailViewModel {
        return LoginWithEmailViewModel(authRepository: provideAuthRepository())
    }
}
