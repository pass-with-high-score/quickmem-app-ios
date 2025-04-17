//
//  LoadingOverlayView.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/17/25.
//

import SwiftUI

struct LoadingOverlayView: View {
    @Binding var isLoading: Bool
    @State private var ellipsisCount: Int = 1

    var body: some View {
        if isLoading {
            ZStack {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)

                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2)
                    .rotationEffect(.degrees(isLoading ? 360 : 0))
                    .animation(
                        .linear(duration: 1)
                        .repeatForever(autoreverses: false),
                        value: isLoading
                    )
                    .frame(width: 100, height: 100)
                
                .blur(radius: 5)
                
                // Animated loading text with increasing and decreasing ellipsis
                Text(
                    "loading_label".localized + String(
                        repeating: ".",
                        count: ellipsisCount
                    )
                )
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 120)
                    .opacity(isLoading ? 1 : 0)
                    .onAppear {
                        startEllipsisAnimation()
                    }
            }
        }
    }

    func startEllipsisAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            if self.ellipsisCount < 3 {
                self.ellipsisCount += 1
            } else {
                self.ellipsisCount = 1
            }
        }
    }
}

