//
//  ContentView.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/12/25.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    var body: some View {
           if hasSeenOnboarding {
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
