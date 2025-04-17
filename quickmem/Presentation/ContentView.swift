//
//  ContentView.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/12/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    var body: some View {
        switch viewModel.appState {
        case .onboarding:
            OnboardingView()
        case .login:
            LoginView()
        case .main:
            MainTabView()
        }
    }
}

#Preview {
    ContentView()
}
