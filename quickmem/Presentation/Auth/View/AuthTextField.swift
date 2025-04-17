//
//  AuthTextField.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/16/25.
//

import SwiftUI

struct AuthTextField: View {
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    var icon: String? = nil

    var body: some View {
        HStack {
            if let icon = icon {
                Image(systemName: icon)
                    .foregroundColor(.gray)
            }

            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.01), radius: 4, x: 0, y: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
        .padding(.horizontal)
    }
}
