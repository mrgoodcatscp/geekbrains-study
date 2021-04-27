//
//  GroupsController.swift
//  ViTruVK
//
//  Created by Вадим Терехов on 09.02.2021.
//


//@IBAction func addGroup(segue: UIStoryboardSegue) {
//    if segue.identifier == "addGroup" {
//        let allGroupsController = segue.source as! AllGroupsController
//        if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
//            let group = groupArr[indexPath.row]
//            if !myGroups.contains(group) {
//                myGroups.append(group)
//                tableView.reloadData()
//            }
//        }
//    }
//}

import UIKit
import RealmSwift
import SDWebImage

class GroupsController: UITableViewController {

    @IBOutlet weak var groupSearchBar: UISearchBar!
    @IBOutlet var groupsTable: UITableView!
    
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
    
    var groupDict = [String: [Group]]()
    var filteredArr = [Group]()
    var groupArr = [Group]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.groupSearchBar.delegate = self
        
        loadData()
        
    }
    
    fileprivate func loadData(completion: (() -> Void)? = nil) {
        networkManager.getGroups { [weak self] (result) in
            switch result {
            case .success(let groupList):
                DispatchQueue.main.async {
                    try? self?.realmManager?.add(objects: groupList)
                    self?.tableView.reloadData()
                    completion?()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    fileprivate func loadLocalData() {
        
        let groupResults: Results<Group>? = self.realmManager?.getObjects()
        guard let groupList: [Group] = groupResults?.toArray() else {return}
        self.groupArr = groupList
        self.filteredArr = groupList
        self.fillTheDictionary()
        self.tableView.reloadData()
        
    }
    
    func loadData() {
        networkManager.getGroups { [weak self] (result) in
            switch result {
            case .success(let groupsList):
                DispatchQueue.main.async {
                    self?.groupArr = groupsList
                    self?.filteredArr = groupsList
                    self?.fillTheDictionary()
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fillTheDictionary() {
        
//        Наполнение словаря для отображения
        
        groupDict = [String: [Group]]()
        
        for item in filteredArr {
            let groupKey = item.nameInitial
            if var userVal = groupDict[groupKey] {
                if !userVal.contains(item) {
                    userVal.append(item)
                    groupDict[groupKey] = userVal
                }
            } else {
                groupDict[groupKey] = [item]
            }
        }
        
        tableSectionTitles = [String](groupDict.keys)
        tableSectionTitles = tableSectionTitles.sorted(by: { $0 < $1 })
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableSectionTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let userKey = tableSectionTitles[section]
        guard let userVal = groupDict[userKey] else {
            return 0
        }
        
        return userVal.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myGroupCell", for: indexPath) as? GroupCell else {
            return UITableViewCell()
        }
        
        let groupKey = tableSectionTitles[indexPath.section]
        if let groupVal = groupDict[groupKey] {
            
    //        Настройки для тени и скругления углов
            let roundingRadius = cell.myGroupPic.frame.size.height / 2
            let shadowOpacity: Float = 1
            let shadowRadius: CGFloat = 5
            
            cell.groupName.text = groupVal[indexPath.row].name
            
    //        Тень контейнера
            cell.avatarContainer.clipsToBounds = false
            cell.avatarContainer.layer.shadowColor = UIColor.black.cgColor
            cell.avatarContainer.layer.shadowOpacity = shadowOpacity
            cell.avatarContainer.layer.shadowRadius = shadowRadius
            cell.avatarContainer.layer.shadowOffset = CGSize.zero
            cell.avatarContainer.layer.cornerRadius = roundingRadius
            cell.avatarContainer.layer.shadowPath = UIBezierPath(roundedRect: cell.avatarContainer.bounds, cornerRadius: roundingRadius).cgPath
            
    //        А изображение просто подчинено
            cell.myGroupPic.clipsToBounds = true
            cell.myGroupPic.frame = cell.avatarContainer.bounds
            cell.myGroupPic.layer.cornerRadius = roundingRadius
            let stringURL = groupVal[indexPath.row].avatar
            DispatchQueue.global().async {
                let data: Data = NetworkManager.shared.getImageData(stringURL: stringURL)
                DispatchQueue.main.async {
                    cell.myGroupPic.image = UIImage(data: data)
                    cell.myGroupPic.sd_setImage(with: URL(string: stringURL))
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
    
    @objc func refresh(_ sender: UIRefreshControl) {
        loadData() { [weak self] in
            self?.refresher.endRefreshing()
        }
    }

    
}

extension GroupsController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        var searched = [Group]()

        for group in groupArr {
            
            if  group.name.lowercased().contains(searchText.lowercased()) {
                searched.append(group)
            }
        }

        if searchText.count != 0 {
            self.filteredArr = searched
        } else {
            self.filteredArr = groupArr
        }

        fillTheDictionary()
        
        self.groupsTable.reloadData()
    }
}

