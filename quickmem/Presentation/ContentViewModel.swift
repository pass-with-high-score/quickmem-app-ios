//
//  ContentViewModel.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/12/25.
//

import SwiftUI

class ContentViewModel : ObservableObject {
    @Published var isOnboarded: Bool = false
    
    private let dataManager = DataManager.shared
    
    init() {
           loadUserData()
       }
    
    func loadUserData() {
            isOnboarded = dataManager.getOnboardedStatus() ?? false
        }
}
