//
//  UserPhotoViewController.swift
//  ViTruVK
//
//  Created by Вадим Терехов on 28.02.2021.
//

import UIKit

class UserPhotoViewController: UIViewController {
    
    @IBOutlet weak var dot1: UIView!
    @IBOutlet weak var dot2: UIView!
    @IBOutlet weak var dot3: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dot1.layer.cornerRadius = dot1.frame.size.height / 2
        self.dot2.layer.cornerRadius = dot2.frame.size.height / 2
        self.dot3.layer.cornerRadius = dot3.frame.size.height / 2
        
        animateDots()
        
    }
    
    func animateDots() {
        
        let duration: Double = 0.4
        
        UIView.animate(withDuration: duration, animations: {
            self.dot1.alpha = 1
            self.dot2.alpha = 0.33
            self.dot3.alpha = 0.66
        }, completion: { _ in
            UIView.animate(withDuration: duration, animations: {
                self.dot2.alpha = 1
                self.dot3.alpha = 0.33
                self.dot1.alpha = 0.66
            }, completion: { _ in
                UIView.animate(withDuration: duration, animations: {
                    self.dot3.alpha = 1
                    self.dot1.alpha = 0.33
                    self.dot2.alpha = 0.66
                }, completion: { _ in
                    self.animateDots()
                })
            })
        })
    }
}
