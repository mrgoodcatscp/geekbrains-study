//
//  AllGroupsCell.swift
//  ViTruVK
//
//  Created by Вадим Терехов on 09.02.2021.
//

import UIKit

class AllGroupsCell: UITableViewCell {

    @IBOutlet weak var foundGroupLabel: UILabel!
    @IBOutlet weak var foundGroupPic: UIImageView!
    @IBOutlet weak var avatarContainer: UIView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
