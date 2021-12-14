//
//  Extensions.swift
//  VK_SwiftUI
//
//  Created by Вадим Терехов on 06.12.2021.
//

import SwiftUI

extension View {
    
    func avatarStyle() -> some View {
        self.modifier(AvatarViewModifier())
    }
    
}

extension UIApplication {
    
    func endEditing() {
        self.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

