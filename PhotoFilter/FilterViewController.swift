//
//  ViewController.swift
//  HelloRxSwift
//
//  Created by Kelvin Fok on 16/7/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit
import RxSwift

class FilterViewController: UIViewController {
    
    @IBOutlet weak var applyFilterButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        applyFilterButton.isHidden = true
        imageView.backgroundColor = .lightGray
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let nav = segue.destination as? UINavigationController, let photoVC = nav.viewControllers.first as? PhotosCollectionViewController else { fatalError("segue is not found") }
        
        photoVC.selectedPhoto.subscribe(onNext: { (photo) in
            print("photo: \(photo)")
            OperationQueue.main.addOperation {
                self.updateUI(with: photo)
            }
        }).disposed(by: disposeBag)
        
    }
    
    private func updateUI(with image: UIImage) {
        self.imageView.image = image
        self.applyFilterButton.isHidden = false
    }

    @IBAction func applyButtonTapped(_ sender: Any) {
        guard let sourceImage = self.imageView.image else { return }
//        FilterService().applyFilter(to: sourceImage) { (filteredImage) in
//            OperationQueue.main.addOperation {
//                self.updateUI(with: filteredImage)
//            }
//        }
        
        FilterService().applyFilter(to: sourceImage).subscribe(onNext: { (filteredImage) in
            OperationQueue.main.addOperation {
                self.imageView.image = filteredImage
            }
        }).disposed(by: disposeBag)
    }
}
