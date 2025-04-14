//
//  GlobalFontModifier.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/13/25.
//

import SwiftUI

struct GlobalFontModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.oswaldVariableFontWght(size: 16))
    }
}
