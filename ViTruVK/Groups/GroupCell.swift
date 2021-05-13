//
//  GroupCell.swift
//  ViTruVK
//
//  Created by Вадим Терехов on 09.02.2021.
//

import UIKit

class GroupCell: UITableViewCell {
    
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var myGroupPic: UIImageView!
    @IBOutlet weak var avatarContainer: UIView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

    }

}
