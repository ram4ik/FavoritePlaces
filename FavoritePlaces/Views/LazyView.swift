//
//  LazyView.swift
//  FavoritePlaces
//
//  Created by Ramill Ibragimov on 28.05.2023.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let content: () -> Content
    
    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        content()
    }
}
