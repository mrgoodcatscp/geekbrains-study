//
//  NewsCell.swift
//  ViTruVK
//
//  Created by Вадим Терехов on 27.02.2021.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var newsText: UITextView!
    @IBOutlet weak var newsImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setNews(news: News) {
        
        self.userImage.image = UIImage(named: news.userPosted.avatar)
        self.userName.text = news.userPosted.fullName
        self.newsText.text = news.text
        self.newsImage.image = UIImage(named: news.photo)
        
        self.userImage.layer.cornerRadius = self.userImage.frame.size.height / 2
    }
    
    
    
    
}
