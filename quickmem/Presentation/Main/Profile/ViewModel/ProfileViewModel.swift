//
//  ProfileViewModel.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/17/25.
//
import Foundation

class ProfileViewModel: ObservableObject {
    
    func logout() {
        Task {
            await AppManager.shared.clearUserData()
            await TokenManager.shared.clearTokens()
        }
    }
    
}
