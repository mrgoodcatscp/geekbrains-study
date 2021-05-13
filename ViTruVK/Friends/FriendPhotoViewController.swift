//
//  FriendPhotoViewController.swift
//  ViTruVK
//
//  Created by Вадим Терехов on 11.02.2021.
//

import UIKit
import RealmSwift
import SDWebImage

var sendedIndex: Int = 0

class FriendPhotoViewController: UICollectionViewController {
    
    private let networkManager = NetworkManager.shared
    private let realmManager = RealmManager.shared
    private var token = Session.shared.token
    
    let reuseIdentifier = "friendsPhotoCell"
    let friendPhotoSectionsNumber: Int = 1
    var friendId: Int?
    var photoArr: [Photo] = []
//    var sendedIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        loadLocalData()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return friendPhotoSectionsNumber
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArr.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FriendPhotoViewCell else { return UICollectionViewCell() }
        
        guard let stringURL = self.photoArr[indexPath.row].url else { return UICollectionViewCell() }
        
        DispatchQueue.global().async {
            let data: Data = NetworkManager.shared.getImageData(stringURL: stringURL)
            DispatchQueue.main.async {
                cell.friendsPhoto.image = UIImage(data: data)
//                cell.friendsPhoto.sd_setImage(with: URL(string: stringURL))
            }
        }
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        sendedIndex = indexPath.row
    }

    fileprivate func loadData(completion: (() -> Void)? = nil) {
        networkManager.getFriendPhotos(userid: friendId ?? 0) { [weak self] (result) in
            switch result {
            case .success(let photoList):
                DispatchQueue.main.async {
                    try? self?.realmManager?.add(objects: photoList)
                    self?.collectionView.reloadData()
                    completion?()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    fileprivate func loadLocalData() {
        
        let photoResults: Results<Photo>? = self.realmManager?.getObjects()
        guard let photoList: [Photo] = photoResults?.toArray() else {return}
        for photo in photoList {
            if photo.userId == friendId && !photoArr.contains(photo){
                photoArr.append(photo)
            }
        }
//        self.photoArr = photoList
        self.collectionView.reloadData()
        
    }
    
}

extension FriendPhotoViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//       TODO: Реакция на ориентацию дисплея
        
        func calculateSizeOfCell(cellsInRowCount: Int) -> CGFloat {
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat(cellsInRowCount - 1))
            let boundsWidth = collectionView.bounds.width
            return CGFloat((boundsWidth - totalSpace) / CGFloat(cellsInRowCount))
        }
        
        let sizeOfCell = calculateSizeOfCell(cellsInRowCount: 3)
        
        return CGSize(width: sizeOfCell, height: sizeOfCell)
    }
}

extension FriendPhotoViewController {
    
//    func showPhoto(_ index: String) {
//
//        let imageView = UIImageView(image: UIImage(named: index))
//        self.view.addSubview(imageView)
//
//    }
    
}
