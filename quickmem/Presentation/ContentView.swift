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
        if viewModel.isOnboarded {
               WelcomeView()
           } else {
               OnboardingView()
                   .onAppear {
                       
                   }
           }
       }
}

#Preview {
    ContentView()
}
