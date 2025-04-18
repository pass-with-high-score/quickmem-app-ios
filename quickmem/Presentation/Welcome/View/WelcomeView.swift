//
//  WelcomeView.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/12/25.
//

import SwiftUI

struct WelcomeView: View {
    @State private var showSignup = false
    @State private var showLogin = false
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
                VStack {
                    Image(AppIcons.appLogo)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .padding(.bottom, 16)
                        .opacity(0.95)
                        .shadow(color: .black.opacity(0.2), radius: 8, y: 4)

                    Text("app_name")
                        .font(.firaSansExtraBold(size: 40))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [
                                    Color.primaryColor,
                                    Color.primaryColor
                                        .opacity(0.7),
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )

                    (Text("all_tools_title")

                        .font(.title3)
                        .fontWeight(.semibold)
                        + Text("in_one_app")
                        .foregroundColor(Color.premiumColor)
                        .font(.title)
                        .fontWeight(.bold))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.horizontal, 32)
                        .padding(.top, 8)

                    VerticalTextCarousel()
                        .padding(.top, 24)

                    Spacer()

                    VStack(spacing: 16) {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                showSignup = true
                            }
                        }) {
                            Text("welcome_button_get_started")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(Color.primaryColor)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(
                                            Color.white.opacity(0.8),
                                            lineWidth: 2)
                                )
                                .shadow(
                                    color: Color.black.opacity(0.3), radius: 5,
                                    x: 0, y: 3
                                )

                        }
                        .padding(.horizontal, 32)

                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                showLogin = true
                            }
                        }) {
                            Text("welcome_button_already_have_account")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(Color.primaryColor)
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(
                                            Color.primaryColor.opacity(0.8),
                                            lineWidth: 2)
                                )
                                .shadow(
                                    color: Color.black.opacity(0.3), radius: 5,
                                    x: 0, y: 3
                                )

                        }
                        .padding(.horizontal, 32)
                    }
                    Spacer()
                        .frame(height: 50)

                }
            }
            .navigationDestination(isPresented: $showSignup) {
                SignupView()
            }
            .navigationDestination(isPresented: $showLogin) {
                LoginView()
            }

        }
        .navigationBarBackButtonHidden(true)
        .interactiveDismissDisabled()
    }
}

#Preview {
    WelcomeView()
}
