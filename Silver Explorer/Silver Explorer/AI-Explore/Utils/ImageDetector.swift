//
//  ImageDetector.swift
//  MLTextAssistant
//
//  Created by Demian on 2023/08/03.
//

import Foundation
import UIKit
import CoreML
import Vision

class ImageDetector {
    public var correctedImages: [CIImage] = []
    
    init(documentImage: UIImage) {
        let documentRequestHandler = VNImageRequestHandler(cgImage: documentImage.cgImage!)
        let rectangleImageDetection = VNDetectRectanglesRequest { [weak self] request, error in
            var rawRectangleObservations = request.results as! [VNRectangleObservation]
            rawRectangleObservations.sort{ $0.boundingBox.origin.y > $1.boundingBox.origin.y }
            
            for rectangleImage in rawRectangleObservations {
                guard let correctedImage = self!.perspectiveCorrectedImage(from: CIImage(cgImage: documentImage.cgImage!), rectangleObservation: rectangleImage)
                else {
                    print("Could not extract an image")
                    return
                }
                
                self!.correctedImages.append(correctedImage)
            }
        }
        
        rectangleImageDetection.maximumObservations = 0
        
        do {
            try documentRequestHandler.perform([rectangleImageDetection])
        }
        catch {
            print(error)
        }
    }
    
    private func perspectiveCorrectedImage(from inputImage: CIImage, rectangleObservation: VNRectangleObservation) -> CIImage? {
        let imageSize = inputImage.extent.size
            
        // Verify detected rectangle is valid.
        let boundingBox = rectangleObservation.boundingBox.scaled(to: imageSize)
        guard inputImage.extent.contains(boundingBox)
        else { print("invalid detected rectangle"); return nil}
            
        // Rectify the detected image and reduce it to inverted grayscale for applying model.
        let topLeft = rectangleObservation.topLeft.scaled(to: imageSize)
        let topRight = rectangleObservation.topRight.scaled(to: imageSize)
        let bottomLeft = rectangleObservation.bottomLeft.scaled(to: imageSize)
        let bottomRight = rectangleObservation.bottomRight.scaled(to: imageSize)
        let correctedImage = inputImage
            .cropped(to: boundingBox)
            .applyingFilter("CIPerspectiveCorrection", parameters: [
                "inputTopLeft": CIVector(cgPoint: topLeft),
                "inputTopRight": CIVector(cgPoint: topRight),
                "inputBottomLeft": CIVector(cgPoint: bottomLeft),
                "inputBottomRight": CIVector(cgPoint: bottomRight)
            ])
        return correctedImage
    }
}



extension CGPoint {
    func scaled(to size: CGSize) -> CGPoint {
        return CGPoint(x: self.x * size.width, y: self.y * size.height)
    }
}
extension CGRect {
    func scaled(to size: CGSize) -> CGRect {
        return CGRect(
            x: self.origin.x * size.width,
            y: self.origin.y * size.height,
            width: self.size.width * size.width,
            height: self.size.height * size.height
        )
    }
}
