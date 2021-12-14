//
//  AvatarViewModifier.swift
//  VK_SwiftUI
//
//  Created by Вадим Терехов on 05.12.2021.
//

import SwiftUI

struct AvatarViewModifier: ViewModifier {
    
    private let padding: CGFloat = 5
    private let sideLength: CGFloat = 50
    private let shadowColor: Color = .blue
    private let shadowRadius: CGFloat = 3

    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .frame(width: sideLength, height: sideLength)
            .cornerRadius(sideLength / 2)
            .shadow(color: shadowColor, radius: shadowRadius, x: 0, y: 0)
            .padding(padding)
    }
    
}
