//
//  ViewExtension.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/13/25.
//

import SwiftUI

extension View {
    func globalFont() -> some View {
        self.modifier(GlobalFontModifier())
    }
}
