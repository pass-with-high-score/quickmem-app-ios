//
//  AuthButton.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/14/25.
//

import SwiftUI

struct AuthButton: View {
    let icon: Image?
    let title: String
    let action: () -> Void
    var backgroundColor: Color = .blue
    var foregroundColor: Color = .white

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                if let icon = icon {
                    icon
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                }
                Text(title)
                    .fontWeight(.bold)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 20))

        }
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(
                    Color.gray.opacity(0.1),
                    lineWidth: 2)
        )
        .padding(.horizontal, 32)
    }
}

#Preview {
    AuthButton(
        icon: Image(systemName: "envelope"),
        title: "Login with email",
        action: {},
        backgroundColor: .blue
    )
    .preferredColorScheme(.dark)
    .padding()
    .background(Color.black)
    .ignoresSafeArea()
}
