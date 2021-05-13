//
//  Group.swift
//  ViTruVK
//
//  Created by Вадим Терехов on 13.02.2021.
//

import Foundation
import RealmSwift

class Group: Object, Decodable {
    
    @objc dynamic var id = 0
    @objc dynamic var name: String = ""
    @objc dynamic var avatar: String = ""
    
    @objc dynamic var nameInitial: String {
        return String(name.prefix(1))
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

