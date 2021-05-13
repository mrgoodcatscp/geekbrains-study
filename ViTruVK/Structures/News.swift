//
//  News.swift
//  ViTruVK
//
//  Created by Вадим Терехов on 27.02.2021.
//

import Foundation

class Attachement: Decodable {
    
    var photos: [String]?
    
}

class News: Decodable {
    
    var id: Int?
    var date: Date?
    var text: String?
    var attachements: [Attachement]?
    
    enum CodingKeys: String, CodingKey {
        case id = "source_id"
        case date
        case text
        case attachements
    }
}


class NewsList: Decodable {
    
    let items: [News]
    let profiles: [User]
    let groups: [Group]
    
    enum CodingKeys: String, CodingKey {
        case items
        case profiles
        case groups
    }
}


class NewsFeedResponse: Decodable {
    
    let response: NewsList
    
    enum CodingKeys: String, CodingKey {
        case response
    }

}



