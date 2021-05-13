//
//  User.swift
//  ViTruVK
//
//  Created by Вадим Терехов on 13.02.2021.
//

import Foundation
import RealmSwift

class User: Object, Decodable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var fullName: String {
        let fqn: String = "\(firstName) \(lastName)"
        return fqn
    }
    @objc dynamic var nameInitial: String {
        return String(firstName.prefix(1))
    }
    @objc dynamic var avatar: String = ""
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "photo_50"
    }
}


class FriendsList: Decodable {
    
    let items: [User]
    let count: Int?
    
    enum CodingKeys: String, CodingKey {
        case items
        case count
        
    }
}


class FriendsResponse: Decodable {
    
    let response: FriendsList
    
    enum CodingKeys: String, CodingKey {
        case response
    }

}
