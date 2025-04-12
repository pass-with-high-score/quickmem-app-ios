//
//  OnboardingPageView.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/12/25.
//

import SwiftUI

struct OnboardingPageView: View {
    let title: String
    let description: String
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundStyle(.accent)
            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            Spacer()
        }
        .padding(.horizontal, 5)
    }
}

#Preview {
    OnboardingPageView(
        title: "Welcome to QuickMem", description: "QuickMem is a flashcard app that helps you learn anything"
    )
}
