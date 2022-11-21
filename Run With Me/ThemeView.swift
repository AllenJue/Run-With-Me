//
//  ThemeView.swift
//  Run With Me
//
//  Created by Allen Jue on 11/20/22.
//

import SwiftUI

struct ThemeView: View {
    let theme: Theme
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(theme.mainColor)
            Text(theme.name)
                
        }
        .background(theme.mainColor)
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct ThemeView_Preview: PreviewProvider {
    static var previews: some View {
        ThemeView(theme: .pastey)
    }
}
