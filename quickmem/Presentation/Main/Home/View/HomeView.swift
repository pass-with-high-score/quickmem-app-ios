//
//  HomeView.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/16/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @EnvironmentObject var contentViewModel: ContentViewModel
    
    var body: some View {
        Text("Home")
    }
}

#Preview {
    HomeView()
        .environmentObject(ContentViewModel())
}
