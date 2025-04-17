//
//  LoginWithEmailView.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/14/25.
//

import SwiftUI

struct LoginWithEmailView: View {
    @StateObject var viewModel: LoginWithEmailViewModel
    @EnvironmentObject var contentViewModel: ContentViewModel

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
                    Spacer().frame(height: 120)

                    // Input
                    AuthTextField(
                        placeholder: "login_email_placeholder".localized,
                        text: $viewModel.email,
                        isSecure: false,
                        icon: "envelope"
                    )

                    AuthTextField(
                        placeholder: "login_password_placeholder".localized,
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
                                Text("login_forgot_password_label")
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
                        title: "login_button_label".localized,
                        action: {
                            _ = viewModel.login()
                        },
                        backgroundColor: .primaryColor
                    )

                    HStack {
                        Text("login_dont_have_an_account_label")
                            .font(.headline)
                            .foregroundColor(.primary.opacity(0.8))
                        NavigationLink {
                            SignupView()
                        } label: {
                            Text("login_signup_label")
                                .underline()
                        }
                        .font(.headline)
                        .foregroundColor(.appPrimary)
                        .bold()
                    }
                    .font(.footnote)
                    .padding(.bottom, 20)
                    Spacer()
                    Text("login_term_of_service")
                        .font(.subheadline)
                        .foregroundColor(.appPrimary.opacity(0.8))
                        .underline()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
                .padding()

                LoadingOverlayView(isLoading: $viewModel.isLoading)

            }
            .alert(isPresented: .constant(viewModel.errorMessage != nil)) {
                Alert(
                    title: Text("error_title"),
                    message: Text(viewModel.errorMessage ?? ""),
                    dismissButton: .default(
                        Text("OK"),
                        action: {
                            viewModel.errorMessage = nil
                        })
                )
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
            .onChange(of: viewModel.isLoggedIn) { isLoggedIn in
                if isLoggedIn {
                    contentViewModel.appState = .main
                }
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
    .environmentObject(ContentViewModel())
}
