//
//  ContentViewModel.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/12/25.
//

import Foundation

class OnboardingViewModel : ObservableObject {
    
    private let dataManager = AppManager.shared
    
    func setOnboardedStatus(_ status: Bool) {
        Task {
            await dataManager.setOnboardedStatus(status)
        }
    }
}
