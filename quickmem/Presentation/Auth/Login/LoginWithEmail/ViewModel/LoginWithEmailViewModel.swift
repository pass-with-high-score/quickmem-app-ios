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

            // Check if email is empty
            guard !self.email.isEmpty else {
                self.errorMessage = "Email không được để trống"
                promise(
                    .failure(
                        NSError(
                            domain: "LoginWithEmailViewModel",
                            code: -1,
                            userInfo: [
                                NSLocalizedDescriptionKey:
                                    "Email không được để trống"
                            ]
                        )
                    )
                )
                return
            }

            // Check if password is empty
            guard !self.password.isEmpty else {
                self.errorMessage = "Mật khẩu không được để trống"
                promise(
                    .failure(
                        NSError(
                            domain: "LoginWithEmailViewModel",
                            code: -1,
                            userInfo: [
                                NSLocalizedDescriptionKey:
                                    "Mật khẩu không được để trống"
                            ]
                        )
                    )
                )
                return
            }

            // Set loading state
            self.isLoading = true

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
                        self.errorMessage =
                            "Đăng nhập thất bại: \(error.localizedDescription)"
                    }
                    promise(.failure(error))
                }
            }

        }
    }

}
