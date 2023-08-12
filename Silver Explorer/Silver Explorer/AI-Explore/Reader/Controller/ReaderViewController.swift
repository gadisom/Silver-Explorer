//
//  ReaderViewController.swift
//  MLTextAssistant
//
//  Created by Demian on 2023/07/29.
//

import UIKit
import AVFAudio

class ReaderViewController: UIViewController {
    
    @IBOutlet weak var ttsButton: UIButton!
    @IBOutlet weak var fontSizeButton: UIButton!
    @IBOutlet weak var scrollViewSub: UIView!
    @IBOutlet weak var labelBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textLabel: UILabel!
    var uiImageViews: [UIImageView] = []
    
    weak var documentDataDelegate: DocumentDataDelegate?
    var documentTexts: [String] = []
    var documentImages: [[CIImage]] = []
    let readerResource: ReaderResource = ReaderResource()
    
    
    var fontSize: FontSizeType = .Normal {
        willSet {
//            fontSizeButton.titleLabel?.text = readerResource.fontButtonText[newValue]!
            fontSizeButton.setTitle(readerResource.fontButtonText[newValue], for: .normal)
            fontSizeButton.titleLabel?.font = readerResource.buttonFont
            textLabel.font = UIFont.systemFont(ofSize: readerResource.fontSize[newValue]!)
        }
    }
    
    var ttsStatus: TTSStatusType = .Off {
        willSet {
            ttsButton.titleLabel?.text = readerResource.ttsButtonText[newValue]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDocumentData()
        textLabel.text = documentTexts.first
        TTSManager.shared.setText(text: textLabel.text)
        TTSManager.shared.setDelegate(readerVC: self)
        showImages()
    }
    
    private func loadDocumentData() {
        guard let documents = documentDataDelegate?.documentImages() else {
            return
        }
        
        for document in documents {
            let textRecognizer = TextRecognitionModel(documentImage: document)
            let imageDetector = ImageDetector(documentImage: document)
            documentTexts.append(textRecognizer.texts)
            documentImages.append(imageDetector.correctedImages)
        }
    }
    
    private func showImages() {
        for documentImage in documentImages.first! {
            let image = UIImage(ciImage: documentImage)
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            self.uiImageViews.append(imageView)
        }
        
        let xOffset: CGFloat = 0
        var yOffset: CGFloat = textLabel.frame.maxY + 10
        
        for imageView in uiImageViews {
            let imageWidth = imageView.image!.size.width
            let imageHeight = imageView.image!.size.height
            
            let imageViewWidth = scrollViewSub.frame.width
            let imageViewHeight = imageViewWidth * (imageHeight / imageWidth)
            
            imageView.frame = CGRect(x: xOffset, y: yOffset, width: imageViewWidth, height: imageViewHeight)
            scrollViewSub.addSubview(imageView)
            
            yOffset += imageViewHeight
        }
        
        if let firstImage = uiImageViews.first {
//            let newConstraint = NSLayoutConstraint(item: textLabel!, attribute: .bottom, relatedBy: .equal, toItem: firstImage, attribute: .top, multiplier: 1.0, constant: 10)
//            scrollView.removeConstraint(labelBottomConstraint)
//            scrollView.addConstraint(newConstraint)
            
//            NSLayoutConstraint.activate([
//                scrollView.heightAnchor.constraint(equalToConstant: yOffset)
//            ])
            labelBottomConstraint.constant += yOffset - textLabel.frame.height
            
            var imageViewIterator = uiImageViews.makeIterator()
            var currentImageView = imageViewIterator.next()

            NSLayoutConstraint.activate([
                currentImageView!.leadingAnchor.constraint(equalTo: scrollViewSub.leadingAnchor),
                currentImageView!.heightAnchor.constraint(equalToConstant: currentImageView!.frame.height),
                currentImageView!.trailingAnchor.constraint(equalTo: scrollViewSub.trailingAnchor),
                currentImageView!.topAnchor.constraint(equalTo: textLabel.bottomAnchor)
            ])
            
            while let nextImageView = imageViewIterator.next(), currentImageView != nil {
                NSLayoutConstraint.activate([
                    nextImageView.leadingAnchor.constraint(equalTo: scrollViewSub.leadingAnchor),
                    currentImageView!.heightAnchor.constraint(equalToConstant: currentImageView!.frame.height),
                    currentImageView!.trailingAnchor.constraint(equalTo: scrollViewSub.trailingAnchor),
                    nextImageView.topAnchor.constraint(equalTo: currentImageView!.bottomAnchor)
                ])
                currentImageView = nextImageView
            }
//
//            NSLayoutConstraint.activate([
//                currentImageView!.leadingAnchor.constraint(equalTo: scrollViewSub.leadingAnchor),
//                currentImageView!.widthAnchor.constraint(equalToConstant: scrollViewSub.frame.width),
////                scrollViewSub.bottomAnchor.constraint(equalTo: currentImageView!.bottomAnchor)
//            ])
        }
    }
    
    
    @IBAction func clickFontSizeButton(_ sender: Any) {
        if fontSize == .Normal {
            fontSize = .Large
        }
        else {
            fontSize = .Normal
        }
    }
    
    
    @IBAction func clickTTSButton(_ sender: Any) {
        TTSManager.shared.goTTS(ttsState: self.ttsStatus)
    }
}

extension ReaderViewController: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        ttsStatus = .On
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        ttsStatus = .On
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        ttsStatus = .Off
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        ttsStatus = .Paused
    }
}
