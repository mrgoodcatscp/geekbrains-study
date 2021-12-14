//
//  Group.swift
//  VK_SwiftUI
//
//  Created by Вадим Терехов on 12.12.2021.
//

import Foundation

struct Group: Decodable, Equatable {
    
    var id: Int?
    var name: String?
    var avatar: String?
    
    var nameInitial: String? {
        return String(name?.prefix(1) ?? "")
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatar = "photo_50"
    }
    
}


class GroupsList: Decodable {
    
    let items: [Group]
    let count: Int?
    
    enum CodingKeys: String, CodingKey {
        case items
        case count
    }
    
}


class GroupsResponse: Decodable {
    
    let response: GroupsList
    
    enum CodingKeys: String, CodingKey {
        case response
    }

}
