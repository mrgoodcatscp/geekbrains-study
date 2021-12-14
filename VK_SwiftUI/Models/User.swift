//
//  Friend.swift
//  VK_SwiftUI
//
//  Created by Вадим Терехов on 06.12.2021.
//

import Foundation

struct User: Decodable, Equatable, Identifiable {
    
    var id: Int?
    var firstName: String?
    var lastName: String?
    var fullName: String {
        let fqn: String = "\(firstName ?? "") \(lastName ?? "")"
        return fqn
    }
    var nameInitial: String? {
        return String(firstName?.prefix(1) ?? "")
    }
    var avatar: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "photo_50"
    }
    
}


struct FriendsList: Decodable {
    
    let items: [User]
    let count: Int?
    
    enum CodingKeys: String, CodingKey {
        case items
        case count
    }
    
}


struct FriendsResponse: Decodable {
    
    let response: FriendsList
    
    enum CodingKeys: String, CodingKey {
        case response
    }

}


