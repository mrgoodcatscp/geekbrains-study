//
//  Session.swift
//  ViTruVK
//
//  Created by Вадим Терехов on 17.03.2021.
//

//    MARK: - Синглтон для получения токена

import Foundation

class Session {
    static let shared = Session()
    
    private init(){}
    
    let id: Int = 0
    var token: String = ""
}
