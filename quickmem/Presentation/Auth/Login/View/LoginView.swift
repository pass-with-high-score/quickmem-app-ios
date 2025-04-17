//
//  LoginView.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/13/25.
//

import SwiftUI

struct LoginView: View {
    @State private var isLoginWithEmail = false
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
                    Spacer()
                        .frame(height: 32)
                    Text("login_subtitle")
                        .font(.body)

                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 200)

                    AuthButton(
                        icon: Image(systemName: "envelope"),
                        title: String(localized: "login_with_email"),
                        action: {
                            withAnimation {
                                isLoginWithEmail.toggle()
                            }
                        },
                        backgroundColor: .blue
                    )

                    HStack {
                        Divider()
                            .frame(width: 100, height: 1)
                            .background(Color.gray.opacity(0.5))

                        Text("login_or")
                            .foregroundColor(.primaryColor)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 8)

                        Divider()
                            .frame(width: 100, height: 1)
                            .background(Color.gray.opacity(0.5))
                    }

                    AuthButton(
                        icon: Image(AppIcons.icGoogle),
                        title: String(localized: "login_with_google"),
                        action: {
                            // google login logic
                        },
                        backgroundColor: .white,
                        foregroundColor: .black
                    )

                    AuthButton(
                        icon: Image(systemName: "apple.logo"),
                        title: String(localized: "login_with_apple"),
                        action: {
                            // apple login logic
                        },
                        backgroundColor: .black
                    )

                    NavigationLink(destination: SignupView()) {
                        HStack {
                            Text("login_dont_have_account")
                            Text("login_signup_button")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                        }
                    }
                    .buttonStyle(.plain)

                    Spacer()
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("login_title")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primaryColor)
                    }
                }
                .navigationDestination(isPresented: $isLoginWithEmail) {
                    LoginWithEmailView(
                        viewModel:
                            DependencyInjection
                            .provideLoginWithEmailViewModel()
                    )
                }

            }
        }
    }
}

#Preview {
    LoginView()
}
