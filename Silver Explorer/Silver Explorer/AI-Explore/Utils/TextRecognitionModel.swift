//
//  TextRecognitionModel.swift
//  MLTextAssistant
//
//  Created by Demian on 2023/07/21.
//

import Foundation
import UIKit
import CoreML
import Vision

class TextRecognitionModel {
    private let THRESHOLD_PARAGRAPH_SEPERATING: CGFloat = 0.08
    private let requestHandler: VNImageRequestHandler
    private var request: VNRecognizeTextRequest!
    var texts: String = ""
    
    init(documentImage: UIImage) {
        requestHandler = VNImageRequestHandler(cgImage: documentImage.cgImage!)
        request = VNRecognizeTextRequest(completionHandler: { [weak self] request, error in
            guard let observations =
                    request.results as? [VNRecognizedTextObservation] else {
                return
            }
            
            self?.processText(observations)
        })
        
        self.request.revision = VNRecognizeTextRequestRevision3
        self.request.recognitionLevel = .accurate
        self.request.recognitionLanguages = ["ko-KR", "en-US"]
        
        self.performHandler()
    }
    
    private func processText(_ observations: [VNRecognizedTextObservation]) {
        var recognizedStrings = ""
        var previousYMax: CGFloat = 0
        
        for observation in observations {
            let boundingBox = observation.boundingBox
            let yMin = boundingBox.minY
            
            if previousYMax - yMin > THRESHOLD_PARAGRAPH_SEPERATING {
                recognizedStrings += "\n"
            }

            if let currentSentence = observation.topCandidates(1).first?.string {
                recognizedStrings += currentSentence + "\n"
            }

            previousYMax = boundingBox.maxY
        }
        
        self.texts = recognizedStrings
    }
    
    private func performHandler() {
        do {
            try self.requestHandler.perform([self.request])
        }
        catch {
            print("Unable: \(error)")
            return
        }
    }
}
