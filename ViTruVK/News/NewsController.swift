//
//  NewsController.swift
//  ViTruVK
//
//  Created by Вадим Терехов on 27.02.2021.
//

import UIKit
import RealmSwift

class NewsController: UIViewController {

    @IBOutlet weak var newsTable: UITableView!
    
    private let networkManager = NetworkManager.shared
    private let realmManager = RealmManager.shared
    private var token = Session.shared.token
    
    var newsArrNotifications: NotificationToken?
    var newsArr = [News]()

    let newsCellIdentifier = "newsXibCell"
    let sectionsNumber: Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsTable.delegate = self
        newsTable.dataSource = self

        newsTable.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: newsCellIdentifier)
        
        loadData()
//        loadLocalData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
//    fileprivate func loadData(completion: (() -> Void)? = nil) {
//        networkManager.getNewsFeed { [weak self] (result) in
//            switch result {
//            case .success(let userList):
//                DispatchQueue.main.async {
//                    try? self?.realmManager?.add(objects: userList)
//                    self?.newsTable.reloadData()
//                    completion?()
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    func loadData() {
        networkManager.getNewsFeed { [weak self] (result) in
            switch result {
            case .success(let newsList):
                DispatchQueue.main.async {
                    self?.newsArr = newsList
                    self?.newsTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//    fileprivate func loadLocalData() {
//
//        let newsResults: Results<News>? = self.realmManager?.getObjects()
//        guard let newsList: [News] = newsResults?.toArray() else {return}
//
//        newsArrNotifications = newsResults?.observe { [weak self] (change) in
//
//            switch change {
//
//            case .initial(let users):
//                print("Init: \(users)")
//                self?.newsArr = newsList
//                self?.newsTable.reloadData()
//
//            case .update(let users, deletions: let deletions, insertions: let insertions, modifications: let modifications):
//                print("""
//                    Recount: \(users.count)
//                    Deleted: \(deletions)
//                    Inserted: \(insertions)
//                    Modified: \(modifications)
//                """)
//
//                self?.newsArr = newsList
//                self?.newsTable.reloadData()
//
//            case .error(let error):
//                print("Error: \(error)")
//                print("Description: \(error.localizedDescription)")
//            }
//
//        }
//    }

}

extension NewsController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: newsCellIdentifier, for: indexPath) as? NewsCell else {
            return UITableViewCell()
        }

        cell.setNews(news: newsArr[indexPath.row])
        return cell

    }
}
