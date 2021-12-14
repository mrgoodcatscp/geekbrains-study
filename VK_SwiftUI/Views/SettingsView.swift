//
//  SettingsView.swift
//  VK_SwiftUI
//
//  Created by Вадим Терехов on 13.12.2021.
//

import SwiftUI

struct SettingsView: View {
    
    private let vkStandardColor: String = "VKStandard"
    
    var body: some View {
        
            VStack {
                Spacer()
                Button(action: self.onLogoffButtonPressed) {
                    HStack {
                        Text("Выйти")
                            .foregroundColor(Color("VKStandard"))
                        Image(systemName: "arrow.left.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color("VKStandard"))
                    }
                    .padding()
                }
                
            }
    }
    
    private func onLogoffButtonPressed() {
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
