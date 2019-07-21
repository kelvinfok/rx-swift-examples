//
//  FilterService.swift
//  HelloRxSwift
//
//  Created by Kelvin Fok on 17/7/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit
import RxSwift

class FilterService {
    
    private var context = CIContext()
    
    func applyFilter(to inputImage: UIImage) -> Observable<UIImage> {
        return Observable<UIImage>.create({ observer in
            self.applyFilter(to: inputImage, completion: { (filteredImage) in
                observer.onNext(filteredImage)
            })
            return Disposables.create()
        })
    }
    
    func applyFilter(to inputImage: UIImage, completion: (UIImage) -> Void) {
        let filter = CIFilter(name: "CICMYKHalftone")!
        filter.setValue(0.5, forKey: kCIInputWidthKey)
        if let sourceImage = CIImage(image: inputImage) {
            filter.setValue(sourceImage, forKey: kCIInputImageKey)
            if let cgImage = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) {
                let processedImage = UIImage(cgImage: cgImage, scale: inputImage.scale, orientation: inputImage.imageOrientation)
                completion(processedImage)
            }
        }
    }
}
