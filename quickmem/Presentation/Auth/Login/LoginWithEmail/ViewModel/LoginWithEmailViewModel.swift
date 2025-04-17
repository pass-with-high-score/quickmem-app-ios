//
//  LoginWithEmailViewModel.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/14/25.
//

import Combine
import Foundation
import SwiftUI

class LoginWithEmailViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var authProvider: AuthProvider = .email
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isLoggedIn: Bool = false

    private let authRepository: AuthRepository

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    func login() -> Future<AuthResponseEntity, Error> {
        return Future { [weak self] promise in
            guard let self = self else {
                promise(
                    .failure(
                        NSError(
                            domain: "LoginWithEmailViewModel",
                            code: -1,
                            userInfo: [
                                NSLocalizedDescriptionKey:
                                    "ViewModel already deallocated"
                            ]
                        )
                    )
                )
                return
            }

            guard !self.email.isEmpty else {
                let message = "error_email_empty".localized
                self.errorMessage = message
                promise(
                    .failure(
                        NSError(
                            domain: "LoginWithEmailViewModel", code: -1,
                            userInfo: [
                                NSLocalizedDescriptionKey: message
                            ]
                        )
                    ))
                return
            }
            
            guard self.email.isValidEmail() else {
                        let message = "error_invalid_email".localized
                        self.errorMessage = message
                        promise(
                            .failure(
                                NSError(
                                    domain: "LoginWithEmailViewModel", code: -1,
                                    userInfo: [
                                        NSLocalizedDescriptionKey: message
                                    ]
                                )
                            )
                        )
                        return
                    }

            guard !self.password.isEmpty else {
                let message = "error_password_empty".localized
                self.errorMessage = message
                promise(
                    .failure(
                        NSError(
                            domain: "LoginWithEmailViewModel", code: -1,
                            userInfo: [
                                NSLocalizedDescriptionKey: message
                            ]
                        )
                    ))
                return
            }
            
            guard self.password.isValidPassword() else {
                       let message = "error_password_invalid".localized
                       self.errorMessage = message
                       promise(
                           .failure(
                               NSError(
                                   domain: "LoginWithEmailViewModel", code: -1,
                                   userInfo: [
                                       NSLocalizedDescriptionKey: message
                                   ]
                               )
                           )
                       )
                       return
                   }

            // Set loading state
            self.isLoading = true
            defer { self.isLoading = false }

            // Attempt to login
            Task {
                do {
                    let loginRequest = LoginRequestEntity(
                        email: self.email,
                        password: self.password,
                        provider: self.authProvider
                    )
                    let response = try await self.authRepository.loginWithEmail(
                        loginRequest: loginRequest
                    )

                    await TokenManager.shared.updateTokens(
                        access: response.accessToken,
                        refresh: response.refreshToken
                    )
                    await AppManager.shared.setUserLoggedIn(true)
                    await AppManager.shared.setUserId(response.id)
                    await AppManager.shared.setEmail(response.email)
                    await AppManager.shared.setFullName(response.fullName)
                    await AppManager.shared.setUsername(response.username)

                    await MainActor.run {
                        self.isLoading = false
                        self.isLoggedIn = true
                    }

                    promise(.success(response))
                } catch {

                    await MainActor.run {
                        self.isLoading = false
                        if let apiError = error as? APIError {
                            self.errorMessage =
                                apiError.localizedDescription.toLocalizationKey
                                .localized
                        }
                    }
                    promise(.failure(error))
                }
            }

        }
    }

}
