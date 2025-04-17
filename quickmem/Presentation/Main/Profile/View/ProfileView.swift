//
//  HomeView.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/16/25.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    @EnvironmentObject var contentViewModel: ContentViewModel
    
    var body: some View {
        Button("Logout") {
            viewModel.logout()
            contentViewModel.appState = .login
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(ContentViewModel())
}
