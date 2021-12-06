//
//  Friend.swift
//  VK_SwiftUI
//
//  Created by Вадим Терехов on 06.12.2021.
//

import Foundation

enum FriendGroup: String {
    case friends = "друзья"
    case relatives = "родственники"
    case colleagues = "коллеги"
}

struct Friend: Identifiable {
    var id: UUID?
    let name: String?
    let surname: String?
    let avatar: String?
    let group: FriendGroup?
    
}

// Для наглядности без сетевых запросов

class User {
    
    static let common = User()
    
    let friend1 = Friend(id: UUID(), name: "Пётр", surname: "Петров", avatar: "pregrammor", group: .friends)
    let friend2 = Friend(id: UUID(), name: "Иван", surname: "Иванов", avatar: "pregrammor", group: .relatives)
    let friend3 = Friend(id: UUID(), name: "Майя", surname: "Плисецкая", avatar: "pregrammor", group: .colleagues)
    let friend4 = Friend(id: UUID(), name: "Гена", surname: "Бобков", avatar: "pregrammor", group: .colleagues)
    let friend5 = Friend(id: UUID(), name: "Роман", surname: "Служебный", avatar: "pregrammor", group: .friends)
    
    func getFriendlist() -> [Friend] {
        let userArray = [friend1, friend2, friend3, friend4, friend5]
        return userArray
    }
    
}


