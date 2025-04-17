//
//  ContentViewModel.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/12/25.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var appState: AppState = .onboarding

    private let appManager = AppManager.shared

    init() {
        loadUserData()
    }

    func loadUserData() {
        Task {
            let onboarded = await appManager.getOnboardedStatus()
            let loggedIn = await appManager.isUserLoggedIn()

            await MainActor.run {
                if !onboarded {
                    self.appState = .onboarding
                } else if !loggedIn {
                    self.appState = .login
                } else {
                    self.appState = .main
                }
            }
        }
    }
}

