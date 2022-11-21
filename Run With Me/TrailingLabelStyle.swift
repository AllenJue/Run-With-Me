//
//  TrailingLabelStyle.swift
//  Run With Me
//
//  Created by Allen Jue on 11/18/22.
//

import SwiftUI

/* Simple style for labels, where the label appears with the icon last */
struct TrailingLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

extension LabelStyle where Self == TrailingLabelStyle {
    static var trailingIcon: Self { Self() }
}
