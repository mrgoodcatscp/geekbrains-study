//
//  FriendPhotoViewCell.swift
//  ViTruVK
//
//  Created by Вадим Терехов on 11.02.2021.
//

import UIKit

class FriendPhotoViewCell: UICollectionViewCell {
    
    var wasIPressed: Bool = false
    var currentLikesCount: Int32 = 0
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var friendsPhoto: UIImageView!
    
    @IBAction func setLike(_ sender: Any) {
        
        if wasIPressed == true {
            
            // Более интересная анимация Curl происходит с артефактом по длине :(
            UIView.transition(with: self.likeButton,
                              duration: 0.25,
                              options: .transitionFlipFromTop,
                              animations: {
                                self.currentLikesCount -= 1
                                self.likeButton.setTitle("", for: .normal)
                                self.likeButton.setImage(UIImage.init(systemName: "heart"), for: .normal)
                                self.likeButton.tintColor = UIColor.white
                              }, completion: nil)
            wasIPressed = !wasIPressed
        } else {
            UIView.transition(with: self.likeButton,
                              duration: 0.25,
                              options: .transitionFlipFromBottom,
                              animations: {
                                self.currentLikesCount += 1
                                self.likeButton.setTitle("\(self.currentLikesCount)", for: .normal)
                                self.likeButton.setImage(UIImage.init(systemName: "heart.fill"), for: .normal)
                                self.likeButton.tintColor = UIColor.red
                              }, completion: nil)
            wasIPressed = !wasIPressed
        }
    }
}
