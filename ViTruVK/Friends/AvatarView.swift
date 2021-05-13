//
//  AvatarViewController.swift
//  ViTruVK
//
//  Created by Вадим Терехов on 28.02.2021.
//

import UIKit

class AvatarView: UIView {
    
    // Простое увеличение при касании
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.5, animations: {
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: nil)
    }
    
    // Пружинка по завершении касания
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 0.8,
                       animations: {
                        self.transform = CGAffineTransform(scaleX: 1, y: 1)
                       }, completion: nil)
    }
}
