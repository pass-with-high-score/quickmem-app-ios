//
//  LoginWithEmailState.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/14/25.
//

import Foundation
import Combine

class LoginWithEmailState: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var authProvider: AuthProvider = .email
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
}
