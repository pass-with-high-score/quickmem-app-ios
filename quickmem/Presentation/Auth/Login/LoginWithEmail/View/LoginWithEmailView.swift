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
                        Color.primaryColor.opacity(0.3),
                        Color.white,
                        Color.white,
                        Color.white,
                        Color.white,
                    ],
                    startPoint: .topTrailing,
                    endPoint: .bottomTrailing
                ).ignoresSafeArea()

                VStack(spacing: 16) {
                    Spacer().frame(height: 40)

                    // Input
                    AuthTextField(
                        placeholder: "Email",
                        text: $viewModel.email,
                        isSecure: false,
                        icon: "envelope"
                    )

                    AuthTextField(
                        placeholder: "Password",
                        text: $viewModel.password,
                        isSecure: true,
                        icon: "lock"
                    )

                    HStack {
                        Spacer()
                        Button(
                            action: {

                            },
                            label: {
                                Text("Forgot password?")
                                    .underline()
                            }
                        )
                        .font(.subheadline)
                        .foregroundColor(.appPrimary.opacity(0.8))
                        .padding(.trailing)
                    }

                    // Button
                    AuthButton(
                        icon: nil,
                        title: String(localized: "Login"),
                        action: {
                            _ = viewModel.login()
                        },
                        backgroundColor: .primaryColor
                    )

                    HStack {
                        Text("Don't have an account?")
                            .font(.headline)
                            .foregroundColor(.primary.opacity(0.8))
                        NavigationLink {
                            SignupView()
                        } label: {
                            Text("Sign Up")
                                .underline()
                        }
                        .font(.headline)
                        .foregroundColor(.appPrimary)
                        .bold()
                    }
                    .font(.footnote)
                    .padding(.bottom, 20)
                    Spacer()
                    Text("By continuing, you agree to our Terms of Service")
                        .font(.subheadline)
                        .foregroundColor(.appPrimary.opacity(0.8))
                        .underline()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
                .padding()

            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 10) {
                        Text("login_title")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.appPrimary)
                        Image(systemName: "brain.head.profile")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .fontWeight(.bold)
                            .foregroundColor(.appPrimary)
                    }
                }
            }
            .navigationDestination(isPresented: $viewModel.isLoggedIn) {
                HomeView()
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
