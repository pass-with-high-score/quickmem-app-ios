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
    @Published var state = LoginWithEmailState()

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
                            userInfo: [NSLocalizedDescriptionKey: "ViewModel already deallocated"]
                        )
                    )
                )
                return
            }

            // Check if email is empty
            guard !self.state.email.isEmpty else {
                self.state.errorMessage = "Email không được để trống"
                promise(
                    .failure(
                        NSError(
                            domain: "LoginWithEmailViewModel",
                            code: -1,
                            userInfo: [NSLocalizedDescriptionKey: "Email không được để trống"]
                        )
                    )
                )
                return
            }

            // Check if password is empty
            guard !self.state.password.isEmpty else {
                self.state.errorMessage = "Mật khẩu không được để trống"
                promise(
                    .failure(
                        NSError(
                            domain: "LoginWithEmailViewModel",
                            code: -1,
                            userInfo: [NSLocalizedDescriptionKey: "Mật khẩu không được để trống"]
                        )
                    )
                )
                return
            }

            // Set loading state
            self.state.isLoading = true

            // Attempt to login
            Task {
                do {
                    // Call the login use case or repository method (replace this with your actual login call)
                    let loginRequest = LoginRequestEntity(
                        email: self.state.email,
                        password: self.state.password,
                        provider: self.state.authProvider
                    )
                    let response = try await self.authRepository.loginWithEmail(
                        loginRequest: loginRequest
                    )

                    // If successful, update state and return the result
                    await MainActor.run {
                        self.state.isLoading = false
                        promise(.success(response))
                    }
                } catch {
                    // If an error occurs, update state and return the error
                    await MainActor.run {
                        self.state.isLoading = false
                        self.state.errorMessage = "Đăng nhập thất bại: \(error.localizedDescription)"
                        promise(.failure(error))
                    }
                }
            }
        }
    }

}
