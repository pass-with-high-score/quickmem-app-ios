//
//  HomeView.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/16/25.
//

import SwiftUI

struct LibraryView: View {
    @StateObject var viewModel = LibraryViewModel()
    var body: some View {
        Text("Library")
    }
}

#Preview {
    LibraryView()
}
