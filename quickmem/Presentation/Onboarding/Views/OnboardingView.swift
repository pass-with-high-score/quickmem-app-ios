//
//  OnboardingView.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/12/25.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    
    private let pages = [
        (title: NSLocalizedString("welcome_title", comment: ""),
         description: NSLocalizedString("welcome_desc", comment: "")),
        (title: NSLocalizedString("create_title", comment: ""),
         description: NSLocalizedString("create_desc", comment: "")),
        (title: NSLocalizedString("learn_title", comment: ""),
         description: NSLocalizedString("learn_desc", comment: ""))
    ]
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                LinearGradient(
                    colors: [Color.accentColor, Color.accentColor.opacity(0.1), Color.white],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ).ignoresSafeArea()
                
                VStack {
                    TabView(selection: $currentPage) {
                        TabView(selection: $currentPage) {
                            ForEach(0..<pages.count, id: \.self) { index in
                                OnboardingPageView(
                                    title: pages[index].title,
                                    description: pages[index].description
                                )
                                .tag(index)
                            }
                        }
                    }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                        .animation(.easeInOut, value: currentPage)
                    
                    HStack(spacing: 16) {
                        if currentPage == pages.count - 1 {
                            Button(action: {
                                print("Onboarding completed")
                            }) {
                                Text("get_started_button")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                    .frame(minWidth: 100, maxWidth: 160, minHeight: 50)
                                    .background(Color.accentColor)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.white.opacity(0.8), lineWidth: 2)
                                    )
                                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                            }
                        } else {
                            Button(action: {
                                withAnimation {
                                    currentPage += 1
                                }
                            }) {
                                HStack {
                                    Text("next_button")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(Color.white)
                                        .fontWeight(.bold)
                                }
                                .frame(minWidth: 100, maxWidth: 160, minHeight: 50)
                                .background(Color.accentColor)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.white.opacity(0.8), lineWidth: 2)
                                )
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)

                }.toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        HStack {
                            Image(systemName: "bolt.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(Color.accentColor)
                            Text("app_name")
                                .font(.headline)
                                .foregroundStyle(Color.white)
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        if currentPage < pages.count - 1 {
                            Button("skip_button") {
                                currentPage = pages.count - 1
                            }.foregroundStyle(.blue)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    OnboardingView()
}
