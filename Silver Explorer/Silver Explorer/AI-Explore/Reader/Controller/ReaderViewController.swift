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
        didSet {
            self.fontSizeButton.setTitle(self.readerResource.fontButtonText[self.fontSize], for: .normal)
            self.fontSizeButton.titleLabel?.font = readerResource.buttonFont
            textLabel.font = UIFont.systemFont(ofSize: readerResource.fontSize[fontSize]!)
            fontSizeButton.layoutIfNeeded()
        }
    }
    
    var ttsStatus: TTSStatusType = .Off {
        willSet {
            self.ttsButton.setTitle(readerResource.ttsButtonText[newValue], for: .normal)
            self.ttsButton.titleLabel?.font = readerResource.buttonFont
            ttsButton.layoutIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDocumentData()
        textLabel.text = documentTexts.first
        TTSManager.shared.setText(text: textLabel.text)
        TTSManager.shared.setDelegate(readerVC: self)
        showImages()
        makeCornerRoundShape(targetView: fontSizeButton, cornerRadius: 10)
        makeCornerRoundShape(targetView: ttsButton, cornerRadius: 10)
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
        
        if let _ = uiImageViews.first {
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
        }
    }
    
    @IBAction func clickPreviousButton(_ sender: Any) {
        TTSManager.shared.stop()
        let viewControllers = self.navigationController?.viewControllers
        let viewControllersCount = viewControllers!.count
        
        let scannerViewController = viewControllers![viewControllersCount - 2] as! ScannerViewController
        
        self.navigationController?.popViewController(animated: true)
        scannerViewController.scan()
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
