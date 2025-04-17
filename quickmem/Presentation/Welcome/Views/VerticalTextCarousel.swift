//
//  VerticalTextCarousel.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/14/25.
//

import SwiftUI

struct VerticalTextCarousel: View {
    let texts: [LocalizedStringKey] = [
        "carousel_flashcard",
        "carousel_personalized_learning",
        "carousel_smart_reminder",
        "carousel_progress_tracking",
    ]

    @State private var currentIndex = 0

    var body: some View {
        ZStack {
            ForEach(texts.indices, id: \.self) { index in
                Text(texts[index])
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.horizontal, 32)
                    .opacity(currentIndex == index ? 1 : 0)
                    .offset(y: currentIndex == index ? 0 : 20)
                    .animation(.easeInOut(duration: 0.5), value: currentIndex)
            }
        }
        .frame(height: 60)  
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { _ in
                currentIndex = (currentIndex + 1) % texts.count
            }
        }
    }
}
