//
//  FriendsController.swift
//  ViTruVK
//
//  Created by Вадим Терехов on 11.02.2021.
//

import UIKit
import RealmSwift
import SDWebImage

class FriendsController: UITableViewController {
    
    @IBOutlet weak var friendSearchBar: UISearchBar!
    @IBOutlet var friendsTable: UITableView! {
        didSet {
            self.friendsTable.refreshControl = self.refresher
        }
    }
    
    private let networkManager = NetworkManager.shared
    private let realmManager = RealmManager.shared
    private var token = Session.shared.token
    
    private lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .systemGray
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    var tableSectionTitles = [String]()
    let sectionsNumber: Int = 1
    
    var userDict = [String: [User]]()
    var filteredArr = [User]() 
    var userArr = [User]()
    var chosenFriendId: Int!
    var userArrNotifications: NotificationToken?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.friendSearchBar.delegate = self
        
        loadData()
        loadLocalData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    fileprivate func loadData(completion: (() -> Void)? = nil) {
        networkManager.getFriends { [weak self] (result) in
            switch result {
            case .success(let userList):
                DispatchQueue.main.async {
                    try? self?.realmManager?.add(objects: userList)
                    self?.tableView.reloadData()
                    completion?()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    fileprivate func loadLocalData() {
        
        let usersResults: Results<User>? = self.realmManager?.getObjects()
        guard let userList: [User] = usersResults?.toArray() else {return}
        
        userArrNotifications = usersResults?.observe { [weak self] (change) in
            
            switch change {
            
            case .initial(let users):
                print("Init: \(users)")
                self?.userArr = userList
                self?.filteredArr = userList
                self?.fillTheDictionary()
                self?.tableView.reloadData()
                
            case .update(let users, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                print("""
                    Recount: \(users.count)
                    Deleted: \(deletions)
                    Inserted: \(insertions)
                    Modified: \(modifications)
                """)
                
                self?.userArr = userList
                self?.filteredArr = userList
                self?.fillTheDictionary()
                self?.tableView.reloadData()
                
            case .error(let error):
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
            }
            
        }
        
        
        
    }
    
    fileprivate func fillTheDictionary() {
        
//        Наполнение словаря для отображения
        
        userDict = [String: [User]]()
        
        for item in filteredArr {
            let userKey = item.nameInitial 
            if var userVal = userDict[userKey] {
                if !userVal.contains(item) {
                    userVal.append(item)
                    userDict[userKey] = userVal
                }
            } else {
                userDict[userKey] = [item]
            }
        }
        
        tableSectionTitles = [String](userDict.keys)
        tableSectionTitles = tableSectionTitles.sorted(by: { $0 < $1 })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto" {
            if let destinationVC = segue.destination as? FriendPhotoViewController {
                destinationVC.friendId = chosenFriendId
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableSectionTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let userKey = tableSectionTitles[section]
        guard let userVal = userDict[userKey] else {
            return 0
        }
        
        return userVal.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as? FriendCell else {
            return UITableViewCell()
        }
        
        let userKey = tableSectionTitles[indexPath.section]
        if let userVal = userDict[userKey] {
            
    //        Настройки для тени и скругления углов
            let roundingRadius = cell.avatarContainer.frame.size.height / 2
            let shadowOpacity: Float = 1
            let shadowRadius: CGFloat = 5
            
            cell.friendsName.text = userVal[indexPath.row].fullName
            
    //        Тень контейнера
            cell.avatarContainer.clipsToBounds = false
            cell.avatarContainer.layer.shadowColor = UIColor.black.cgColor
            cell.avatarContainer.layer.shadowOpacity = shadowOpacity
            cell.avatarContainer.layer.shadowRadius = shadowRadius
            cell.avatarContainer.layer.shadowOffset = CGSize.zero
            cell.avatarContainer.layer.cornerRadius = roundingRadius
            cell.avatarContainer.layer.shadowPath = UIBezierPath(roundedRect: cell.avatarContainer.bounds, cornerRadius: roundingRadius).cgPath
            
    //        А изображение просто подчинено
            cell.friendsAvatar.clipsToBounds = true
            cell.friendsAvatar.frame = cell.avatarContainer.bounds
            cell.friendsAvatar.layer.cornerRadius = roundingRadius
            
            let stringURL = userVal[indexPath.row].avatar
            DispatchQueue.global().async {
                let data: Data = NetworkManager.shared.getImageData(stringURL: stringURL)
                DispatchQueue.main.async {
                    cell.friendsAvatar.image = UIImage(data: data)
                    cell.friendsAvatar.sd_setImage(with: URL(string: stringURL))
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableSectionTitles[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return tableSectionTitles
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let userKey = tableSectionTitles[indexPath.section]
        
        if let userVal = userDict[userKey] {
            chosenFriendId = userVal[indexPath.row].id
            
            performSegue(withIdentifier: "showPhoto", sender: nil)
        }
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        loadData() { [weak self] in
            self?.refresher.endRefreshing()
        }
    }
    
}

extension FriendsController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        var searched = [User]()

        for user in userArr {
            if  user.fullName.lowercased().contains(searchText.lowercased()) {
                searched.append(user)
            }
        }

        if searchText.count != 0 {
            self.filteredArr = searched
        } else {
            self.filteredArr = userArr
        }

        fillTheDictionary()

        self.friendsTable.reloadData()
    }
}
