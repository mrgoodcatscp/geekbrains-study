//
//  NetworkManager.swift
//  VK_SwiftUI
//
//  Created by Вадим Терехов on 12.12.2021.
//

import Foundation
import Combine

protocol NetworkManagerInput: AnyObject {
    func getFriendList() -> AnyPublisher<[User], Error>
}

class NetworkManager {
    
    let token: String = UserDefaults.standard.string(forKey: "vkToken")!
    let scheme: String = "https"
    let host: String = "api.vk.com"
    let apiVersion: String = "5.131"
    
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    private static let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = false
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    static let shared = NetworkManager()
    
    private init() {
        
    }
    
    enum NetworkManagerError: Error {
        
        case urlError
        case dataError
        case decodingError
        
    }
    
    
//    MARK: - Список друзей с аватарами (прошлые курсы)
    
    func getFriendList(completion: @escaping (Result<[User], NetworkManagerError>) -> Void) {
        
        var urlComponents = URLComponents()
        var userList = [User]()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "fields", value: "photo_50"),
            URLQueryItem(name: "v", value: "5.130")
        ]
        
        guard let url = urlComponents.url else {
            completion(.failure(.urlError))
            return
        }
        
        let dataTask = NetworkManager.session.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                completion(.failure(.dataError))
                return
            }
            
            do {
                
                let usersDecoded: FriendsResponse = try JSONDecoder().decode(FriendsResponse.self, from: data)
                
                for user in usersDecoded.response.items {
                    userList.append(user)
                }
                
            } catch {
                
                print(error.localizedDescription)
                print(error)
                completion(.failure(.decodingError))
                return
                
            }
            
            completion(.success(userList))

        }
        
        dataTask.resume()
        
    }
    
    
//    MARK: - Список фотографий друга
    
    func getFriendPhotos() {
        
    }
    
    
//    MARK: - Список групп
    
    func getGroups() {
        
    }
    
}
