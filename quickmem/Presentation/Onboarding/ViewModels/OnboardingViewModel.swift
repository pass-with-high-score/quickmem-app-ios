//
//  ContentViewModel.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/12/25.
//

import Foundation

class OnboardingViewModel : ObservableObject {
    
    private let dataManager = DataManager.shared
    
    func setOnboardedStatus(_ status: Bool) {
        dataManager.saveOnboardedStatus(status)
    }
}
