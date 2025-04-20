//
//  SignupView.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/13/25.
//

import SwiftUI

struct SignupView: View {
    @State private var isSignupWithEmail = false
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
                    Text("signup_subtitle")
                        .font(.body)
                    
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 150)
                    
                    AuthButton(
                        icon: Image(systemName: "envelope"),
                        title: String(localized: "signup_with_email"),
                        action: {
                            withAnimation{
                                isSignupWithEmail.toggle()
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
                    (
                        Text("signup_by_signing_up_you_agree_to_the")
                        + Text("signup_terms_and_conditions")
                            .underline()
                            .foregroundColor(.blue)
                            .fontWeight(.bold)
                        + Text("signup_and_the")
                        + Text("signup_privacy_policy")
                            .fontWeight(.bold)
                            .underline()
                            .foregroundColor(.blue)
                        + Text("signup_of_quickmem")
                    )
                    .multilineTextAlignment(.center)
                    .font(.body)
                    
                    NavigationLink(destination: SignupView()) {
                        HStack {
                            Text("signup_already_have_an_account")
                            Text("signup_login_button")
                                .underline()
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                        }
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("signup_title")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primaryColor)
                    }
                }
            }
        }
    }
}

#Preview {
    SignupView()
}
