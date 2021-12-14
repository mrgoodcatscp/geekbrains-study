//
//  UsernameViewBuilder.swift
//  VK_SwiftUI
//
//  Created by Вадим Терехов on 06.12.2021.
//

import SwiftUI

struct UsernameViewBuilder: View {
    var content: Text
 
    init(@ViewBuilder content: () -> Text) {
        self.content = content()
    }
 
    var body: some View {
        content
            .font(.system(size: 20))
            .fontWeight(.light)
            .foregroundColor(.black)
    }
}
