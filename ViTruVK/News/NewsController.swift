//
//  NewsController.swift
//  ViTruVK
//
//  Created by Вадим Терехов on 27.02.2021.
//

import UIKit

//class NewsController: UIViewController {
//
//    @IBOutlet weak var newsTable: UITableView!
//
//    let newsCellIdentifier = "newsXibCell"
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        newsTable.delegate = self
//        newsTable.dataSource = self
//
//        newsTable.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: newsCellIdentifier)
//    }
//
//}
//
//extension NewsController: UITableViewDelegate, UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return newsArr.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: newsCellIdentifier, for: indexPath) as? NewsCell else {
//            return UITableViewCell()
//        }
//
//        cell.setNews(news: newsArr[indexPath.row])
//        return cell
//
//    }
//}
