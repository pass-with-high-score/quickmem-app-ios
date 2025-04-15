//
//  LoginWithEmailView.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/14/25.
//

import SwiftUI

struct LoginWithEmailView: View {
    @StateObject var viewModel: LoginWithEmailViewModel

    init(viewModel: LoginWithEmailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color.primaryColor, Color.primaryColor.opacity(0.3),
                        Color.white,
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ).ignoresSafeArea()

                VStack {
                    TextField("Email", text: $viewModel.state.email)
                        .textFieldStyle(.roundedBorder)
                    SecureField("Password", text: $viewModel.state.password)
                        .textFieldStyle(.roundedBorder)

                    if viewModel.state.isLoading {
                        ProgressView()
                    }

                    if let error = viewModel.state.errorMessage {
                        Text(error).foregroundColor(.red)
                    }

                    Button("Login") {
                        viewModel.login()
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    LoginWithEmailView(
        viewModel: LoginWithEmailViewModel(
            authRepository: DependencyInjection.provideAuthRepository()
        )
    )
}
