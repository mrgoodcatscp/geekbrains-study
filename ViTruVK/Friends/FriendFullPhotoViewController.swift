//
//  FriendFullPhotoViewController.swift
//  ViTruVK
//
//  Created by Вадим Терехов on 13.03.2021.
//

import UIKit

class FriendFullPhotoViewController: UIViewController {

    @IBOutlet weak var fullPhotoImageView: UIImageView!
    
    var photoArr: [String] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        self.view.addGestureRecognizer(recognizer)
        
        let data: Data = NetworkManager.shared.getImageData(stringURL: self.photoArr[sendedIndex])
        fullPhotoImageView.image = UIImage (data: data)
    }
    
    let duration: TimeInterval = 0.3
        
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        
        switch recognizer.state {
        
//        case .began:
//            print("Начало анимации")
            
        case .changed:
            let translation = recognizer.translation(in: self.view)
            let newXPosition = self.fullPhotoImageView.center.x + translation.x
            self.fullPhotoImageView.center = CGPoint(x: newXPosition, y: self.fullPhotoImageView.center.y)
            recognizer.setTranslation(CGPoint.zero, in: self.view)
            UIView.animate(withDuration: 0.5, animations: {
                self.fullPhotoImageView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            })
            
        case .ended, .cancelled:
            
            
            switch fullPhotoImageView.center.x {
            
            case ...10:
                sendedIndex += 1
                if sendedIndex >= self.photoArr.count {
                    sendedIndex -= 1
                    stayStillImage(duration)
                } else {
                    showNextImage(sendedIndex, duration)
                }
                
            case (self.fullPhotoImageView.frame.size.width + 10)...:
                sendedIndex -= 1
                if sendedIndex < 0 {
                    sendedIndex = 0
                    stayStillImage(duration)
                } else {
                    showPreviousImage(sendedIndex, duration)
                }
                
            default:
                stayStillImage(duration)
            }
            
        default: return
        }
    }
    
    func showNextImage (_ index: Int, _ duration: TimeInterval) {
        UIView.animate(withDuration: duration,
                       animations: {
                        self.fullPhotoImageView.center.x = -self.fullPhotoImageView.frame.size.width
                       }, completion: {_ in
                        self.fullPhotoImageView.alpha = 0
                        UIView.animate(withDuration: duration,
                                       animations: {
                                        let data: Data = NetworkManager.shared.getImageData(stringURL: self.photoArr[index])
                                        self.fullPhotoImageView.image = UIImage (data: data)
                                        self.fullPhotoImageView.alpha = 1
                                       })
                       })
    }
    
    func showPreviousImage (_ index: Int, _ duration: TimeInterval) {
        UIView.animate(withDuration: duration,
                       animations: {
                        self.fullPhotoImageView.center.x = self.fullPhotoImageView.frame.size.width + self.view.frame.size.width
                       }, completion: {_ in
                        self.fullPhotoImageView.alpha = 0
                        UIView.animate(withDuration: duration,
                                       animations: {
                                        let data: Data = NetworkManager.shared.getImageData(stringURL: self.photoArr[index])
                                        self.fullPhotoImageView.image = UIImage (data: data)
                                        self.fullPhotoImageView.alpha = 1
                                       })
                       })
    }
    
    func stayStillImage (_ duration: TimeInterval) {
        UIView.animate(withDuration: duration,
                       animations: {
                        self.fullPhotoImageView.transform = .identity
                        self.fullPhotoImageView.center = self.view.center
                       })
    }

}
