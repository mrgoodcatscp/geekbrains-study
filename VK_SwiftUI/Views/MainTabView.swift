//
//  MainTabView.swift
//  VK_SwiftUI
//
//  Created by Вадим Терехов on 13.12.2021.
//

import SwiftUI

struct MainTabView: View {
    
    var body: some View {
        
        TabView {
            FriendListView()
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("Друзья")
                }
            GroupsView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Группы")
                }
            NewsFeedView()
                .tabItem {
                    Image(systemName: "newspaper.fill")
                    Text("Лента")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Настройки")
                }
        }
        
    }
    
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
