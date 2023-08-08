//
//  NewsPaperTextRecognizer.swift
//  MLTextAssistant
//
//  Created by Demian on 2023/07/22.
//

import Foundation
import UIKit
import Vision
import VisionKit
import CoreML

class NewspaperTextRecognizer {
    var recognizedText: String?

    func recognizeText(from image: UIImage) {
        guard let ciImage = CIImage(image: image) else {
            return
        }

        let textRecognitionRequest = VNRecognizeTextRequest{ [weak self] request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                return
            }

            var recognizedText = ""
            for observation in observations {
                guard let topCandidate = observation.topCandidates(1).first else {
                    continue
                }
                recognizedText += topCandidate.string + "\n"
            }

            self?.recognizedText = recognizedText.isEmpty ? nil : recognizedText
        }
        
        textRecognitionRequest.recognitionLevel = .accurate

        let handler = VNImageRequestHandler(ciImage: ciImage)
        do {
            try handler.perform([textRecognitionRequest])
        } catch {
            print("Error performing text recognition: \(error)")
        }
    }
}
