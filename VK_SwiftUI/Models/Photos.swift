//
//  Photos.swift
//  VK_SwiftUI
//
//  Created by Вадим Терехов on 12.12.2021.
//

import Foundation

class Photo: Decodable {
    
    var url: String?
    var userId: Int = 0
    
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
