//
//  VK_SwiftUIApp.swift
//  VK_SwiftUI
//
//  Created by Вадим Терехов on 28.11.2021.
//

import SwiftUI

@main
struct VK_SwiftUIApp: App {
    
    @State var didSignedIn: Bool = false
    
    var body: some Scene {
        
        WindowGroup {
            if didSignedIn {
                MainTabView()
            } else {
                LoginWebView()
                    .onReceive(NotificationCenter.default.publisher(for: .init(rawValue: "vkTokenSaved"))) { _ in
                        didSignedIn = UserDefaults.standard.string(forKey: "vkToken") != nil
                    }
            }
        }
    }
}
