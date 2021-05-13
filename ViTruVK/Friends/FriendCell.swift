//
//  FriendCell.swift
//  ViTruVK
//
//  Created by Вадим Терехов on 11.02.2021.
//

import UIKit

class FriendCell: UITableViewCell {

    @IBOutlet weak var friendsAvatar: UIImageView!
    @IBOutlet weak var friendsName: UILabel!
    @IBOutlet weak var avatarContainer: UIView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
