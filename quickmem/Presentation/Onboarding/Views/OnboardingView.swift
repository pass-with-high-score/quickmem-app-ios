//
//  OnboardingView.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/12/25.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @State private var currentPage = 0
    @State private var showFirework = false
    @State private var fireworkId = UUID()
    @State private var isOnboardingCompleted = false

    private let pages = [
        (
            title: NSLocalizedString("welcome_title", comment: ""),
            description: NSLocalizedString("welcome_desc", comment: "")
        ),
        (
            title: NSLocalizedString("create_title", comment: ""),
            description: NSLocalizedString("create_desc", comment: "")
        ),
        (
            title: NSLocalizedString("learn_title", comment: ""),
            description: NSLocalizedString("learn_desc", comment: "")
        ),
    ]

    var body: some View {
        NavigationStack {

            ZStack {

                LinearGradient(
                    colors: [
                        Color.primaryColor.opacity(0.3),
                        Color.white,
                        Color.white,
                        Color.white,
                        Color.white,
                    ],
                    startPoint: .topTrailing,
                    endPoint: .bottomTrailing
                ).ignoresSafeArea()

                VStack(spacing: currentPage == pages.count - 1 ? 24 : 28) {
                    TabView(selection: $currentPage) {
                        ForEach(0..<pages.count, id: \.self) { index in
                            OnboardingPageView(
                                title: pages[index].title,
                                description: pages[index].description
                            )
                            .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(height: 280)
                    .animation(.easeInOut, value: currentPage)

                    HStack(spacing: 8) {
                        ForEach(0..<pages.count, id: \.self) { index in
                            Circle()
                                .fill(
                                    index == currentPage
                                        ? Color.primaryColor
                                        : Color.gray.opacity(0.4)
                                )
                                .frame(
                                    width: index == currentPage ? 12 : 8,
                                    height: index == currentPage ? 12 : 8
                                )
                                .animation(.spring(), value: currentPage)
                        }
                    }
                    .padding(.top, 12)

                    HStack(spacing: 16) {
                        if currentPage == pages.count - 1 {
                            Button(action: {
                                isOnboardingCompleted = true
                                viewModel.setOnboardedStatus(
                                    isOnboardingCompleted)
                            }) {
                                Text("get_started_button")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                    .frame(
                                        minWidth: 100, maxWidth: 160,
                                        minHeight: 50
                                    )
                                    .background(Color.primaryColor)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 20)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(
                                                Color.white.opacity(0.8),
                                                lineWidth: 2)
                                    )
                                    .shadow(
                                        color: Color.black.opacity(0.3),
                                        radius: 5, x: 0, y: 3)
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
                                .frame(
                                    minWidth: 100, maxWidth: 160, minHeight: 50
                                )
                                .background(Color.primaryColor)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(
                                            Color.white.opacity(0.8),
                                            lineWidth: 1)
                                )
                                .shadow(
                                    color: Color.black.opacity(0.3), radius: 5,
                                    x: 0, y: 3)
                            }
                        }
                    }
                    .padding(.horizontal, 20)

                    if currentPage < pages.count - 1 {
                        Button(action: {
                            currentPage = pages.count - 1
                        }) {
                            Text(LocalizedStringKey("skip_button"))
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundStyle(.gray)
                                .underline()
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                        }
                        .background(Color.clear)
                        .contentShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.top, 8)
                    }

                }.toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        HStack {
                            Button(action: {
                                let generator = UIImpactFeedbackGenerator(
                                    style: .medium)
                                generator.impactOccurred()

                                fireworkId = UUID()
                                withAnimation {
                                    showFirework = true
                                }
                            }) {
                                Image(systemName: "bolt.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .padding(10)
                                    .background(Color.primaryColor)
                                    .clipShape(Circle())
                                    .foregroundStyle(.white)
                            }

                            Text("app_name")
                                .font(.headline)
                                .foregroundStyle(Color.primaryColor)
                        }
                    }

                }
                if showFirework {
                    LottieView(
                        animationName: Lottie.firework, loopMode: .playOnce
                    )
                    .id(fireworkId)
                    .frame(width: 300, height: 300)
                    .transition(.scale.combined(with: .opacity))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showFirework = false
                            }
                        }
                    }

                }
            }.navigationDestination(isPresented: $isOnboardingCompleted) {
                WelcomeView()
            }

        }
    }
}

#Preview {
    OnboardingView()
}
