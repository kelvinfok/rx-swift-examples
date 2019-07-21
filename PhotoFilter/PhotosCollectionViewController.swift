//
//  PhotosCollectionViewController.swift
//  HelloRxSwift
//
//  Created by Kelvin Fok on 16/7/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit
import Photos
import RxSwift

class PhotosCollectionViewController: UICollectionViewController {
    
    private let selectedPhotoSubject = PublishSubject<UIImage>()
    var selectedPhoto: Observable<UIImage> {
        return selectedPhotoSubject.asObservable()
    }
    
    private var images = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populatePhotos()
    }
    
    private func populatePhotos() {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                let assets = PHAsset.fetchAssets(with: .image, options: nil)
                assets.enumerateObjects({ (object, count, stop) in
                    self.images.append(object)
                })
                self.images.reverse()
                OperationQueue.main.addOperation {
                    self.collectionView.reloadData()
                }
            case .denied:
                print("denied")
            default: break
            }
        }
    }
    
    
    
}

extension PhotosCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? PhotoCollectionViewCell else { fatalError() }
        let asset = self.images[indexPath.row]
        let manager = PHImageManager.default()
        
        manager.requestImage(for: asset, targetSize: .init(width: 100, height: 100), contentMode: .aspectFit, options: nil) { (image, _) in
            
            OperationQueue.main.addOperation {
                cell.photoImageView.image = image
            }
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedAsset = self.images[indexPath.item]
        PHImageManager.default().requestImage(for: selectedAsset, targetSize: .init(width: 300, height: 300), contentMode: .aspectFit, options: nil) { (image, info) in
            
            guard let info = info else { return }
            
            let isDegradedImage = info["PHImageResultIsDegradedKey"] as! Bool
            
            if !isDegradedImage {
                if let image = image {
                    self.selectedPhotoSubject.onNext(image)
                    
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
        }
    }
    
    
}

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    
}
