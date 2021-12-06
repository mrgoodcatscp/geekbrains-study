//
//  GroupTextViewBuilder.swift
//  VK_SwiftUI
//
//  Created by Вадим Терехов on 06.12.2021.
//

import Foundation
import SwiftUI

struct GroupTextViewBuilder: View {
    var content: Text
 
    init(@ViewBuilder content: () -> Text) {
        self.content = content()
    }
 
    var body: some View {
        content
            .font(.system(size: 12))
            .border(Color.gray)
            .foregroundColor(Color.white)
            .background(Color.gray)
    }
}
