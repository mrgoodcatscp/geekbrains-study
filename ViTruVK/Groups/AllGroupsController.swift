//
//  AllGroupsController.swift
//  ViTruVK
//
//  Created by Вадим Терехов on 09.02.2021.
//

import UIKit


// MARK: - Надо ещё подумать, как реализовать выдачу


class AllGroupsController: UITableViewController {
    
    @IBOutlet weak var groupSearchBar: UISearchBar!
    @IBOutlet var groupsTable: UITableView!

    private let networkManager = NetworkManager.shared
    private var token = Session.shared.token

    let sectionsNumber: Int = 1

    var searchedGroupArr = [Group]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func loadData() {
        networkManager.getGroups { [weak self] (result) in
            switch result {
            case .success(let groupsList):
                DispatchQueue.main.async {
                    self?.searchedGroupArr = groupsList
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsNumber
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedGroupArr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "foundGroupCellTemplate", for: indexPath) as? AllGroupsCell else {
            return UITableViewCell()
        }
            
    //        Настройки для тени и скругления углов
            let roundingRadius = cell.foundGroupPic.frame.size.height / 2
            let shadowOpacity: Float = 1
            let shadowRadius: CGFloat = 5
            
            cell.foundGroupLabel.text = searchedGroupArr[indexPath.row].name
            
    //        Тень контейнера
            cell.avatarContainer.clipsToBounds = false
            cell.avatarContainer.layer.shadowColor = UIColor.black.cgColor
            cell.avatarContainer.layer.shadowOpacity = shadowOpacity
            cell.avatarContainer.layer.shadowRadius = shadowRadius
            cell.avatarContainer.layer.shadowOffset = CGSize.zero
            cell.avatarContainer.layer.cornerRadius = roundingRadius
            cell.avatarContainer.layer.shadowPath = UIBezierPath(roundedRect: cell.avatarContainer.bounds, cornerRadius: roundingRadius).cgPath
            
    //        А изображение просто подчинено
            cell.foundGroupPic.clipsToBounds = true
            cell.foundGroupPic.frame = cell.avatarContainer.bounds
            cell.foundGroupPic.layer.cornerRadius = roundingRadius
            DispatchQueue.global().async {
                let data: Data = NetworkManager.shared.getImageData(stringURL: self.searchedGroupArr[indexPath.row].avatar )
                DispatchQueue.main.async {
                    cell.foundGroupPic.image = UIImage(data: data)
                }
            }
        
        return cell
    }
    
}
