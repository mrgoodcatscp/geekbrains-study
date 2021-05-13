import Foundation


// MARK: - Сессионный синглтон

class NetworkManager {
    
    var token = Session.shared.token
    
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
    
    // TODO: Ужать до одной функции
    
//    MARK: - Список друзей с аватарами
    
    func getFriends(completion: @escaping (Result<[User], NetworkManagerError>) -> Void) {
        
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
        print(token)
        
    }
    
    
//    MARK: - Список фотографий друга
    
    func getFriendPhotos(userid: Int, completion: @escaping (Result<[Photo], NetworkManagerError>) -> Void) {
        
        var urlComponents = URLComponents()
        var photosList = [Photo]()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.getAll"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: self.token),
            URLQueryItem(name: "owner_id", value: "\(userid)"),
            URLQueryItem(name: "skip_hidden", value: "1"),
            URLQueryItem(name: "v", value: "5.130")
            
        ]
        
        guard let url = urlComponents.url else {
            completion(.failure(.urlError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 30
        
        let dataTask = NetworkManager.session.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                completion(.failure(.dataError))
                return
            }
            
            do {
                
                let photosDecoded: PhotosResponse = try JSONDecoder().decode(PhotosResponse.self, from: data)
                
                for photo in photosDecoded.response.items {
                    let photoObj = Photo()
                    photoObj.id.value = Int.random(in: 0...1000000)
                    photoObj.userId = userid
                    photoObj.url = photo.sizes[0].url
                    photosList.append(photoObj)
                }
                
            } catch {
                
                print(error.localizedDescription)
                print(error)
                completion(.failure(.decodingError))
                return
                
            }
            
            completion(.success(photosList))
            
        }
        
        dataTask.resume()
    }
    
    
//    MARK: - Список групп
    
    func getGroups(completion: @escaping (Result<[Group], NetworkManagerError>) -> Void) {
        
        var urlComponents = URLComponents()
        var groupsList = [Group]()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.130")
        ]
        
        guard let url = urlComponents.url else {
            completion(.failure(.urlError))
            return
        }
        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.timeoutInterval = 30
        
        let dataTask = NetworkManager.session.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                completion(.failure(.dataError))
                return
            }
            
            do {
                
                let groupsDecoded: GroupsResponse = try JSONDecoder().decode(GroupsResponse.self, from: data)
                
                for group in groupsDecoded.response.items {
                    groupsList.append(group)
                }
                
            } catch {
                
                print(error.localizedDescription)
                print(error)
                completion(.failure(.decodingError))
                return
                
            }
            
            completion(.success(groupsList))

        }
    
        dataTask.resume()
    }
    
//    MARK: - Получение новостной ленты
    
    func getNewsFeed(completion: @escaping (Result<[News], NetworkManagerError>) -> Void) {
        
        var urlComponents = URLComponents()
        var newsList = [News]()
        var profilesList = [User]()
        var groupsList = [Group]()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/newsfeed.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "v", value: "5.130")
        ]
        
        guard let url = urlComponents.url else {
            completion(.failure(.urlError))
            return
        }
        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.timeoutInterval = 30
        
        let dataTask = NetworkManager.session.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                completion(.failure(.dataError))
                return
            }
            
            do {
                
                let newsDecoded: NewsFeedResponse = try JSONDecoder().decode(NewsFeedResponse.self, from: data)
                
                for news in newsDecoded.response.items {
                    newsList.append(news)
                }
                for profile in newsDecoded.response.profiles {
                    profilesList.append(profile)
                }
                for group in newsDecoded.response.groups {
                    groupsList.append(group)
                }
                
            } catch {
                
                print(error.localizedDescription)
                print(error)
                completion(.failure(.decodingError))
                return
                
            }
            
            completion(.success(newsList))

        }
    
        dataTask.resume()
    }
    
//    MARK: - Конвертер изображений
    
    func getImageData(stringURL: String) -> Data {
        
        guard let url = URL(string: stringURL) else { return Data() }
        guard let imageData = try? Data(contentsOf: url) else { return Data() }
        return imageData
        
    }
}
