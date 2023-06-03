//
//  BlobToImageConverter.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 31.05.2023.
//

import Foundation
import SwiftUI

class ImageConverter: ObservableObject {
    @Published var img: Image?
    
    func dataToImage(data: Data) {
        if let uiImage = UIImage(data: data) {
            img = Image(uiImage: uiImage)
        }
    }
    //
    //   func imageToData(image: UIImage) -> Data? {
    //       return image.jpegData(compressionQuality: 0.9, )
    //    }
//    func imageToByteArray(image: Image) -> [UInt8]? {
////            guard let uiImage = imageToUIImage(image: image),
////                  let imageData = uiImage.pngData() else {
////                return nil
////            }
//        guard let image = imageToUIImage(image: image) else {
//            return nil
//        }
//
//        return bytes
//    }

    func imageToUIImage(image: Image) -> [UInt8] {
        let hostingController = UIHostingController(rootView: image)
        
        guard let view = hostingController.view else {
            return []
        }
            let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
            let uiImage = renderer.image { _ in
                view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
            }
        if let pngData = uiImage.pngData() {
            let count = pngData.count
            var bytes = [UInt8](repeating: 0, count: count)
            
            pngData.copyBytes(to: &bytes, count: count)
            return bytes
        
    }
        return []
    }



}
