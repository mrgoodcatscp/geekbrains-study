//
//  Photos.swift
//  ViTruVK
//
//  Created by Вадим Терехов on 28.03.2021.
//

import Foundation
import RealmSwift

//var photos = [String]()

class Photo: Object, Decodable {
    
    var id = RealmOptional<Int>()
    @objc dynamic var url: String?
    @objc dynamic var userId: Int = 0
    
    override class func primaryKey() -> String? {
        "id"
    }
    enum CodingKeys: String, CodingKey {
        case url
    }
}

class SizesList: Decodable {
    
    let sizes: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case sizes
    }
}

class PhotosList: Decodable {
    
    let items: [SizesList]
    let count: Int?
    
    enum CodingKeys: String, CodingKey {
        case items
        case count
    }
}


class PhotosResponse: Decodable {
    
    let response: PhotosList
    
    enum CodingKeys: String, CodingKey {
        case response
    }

}
