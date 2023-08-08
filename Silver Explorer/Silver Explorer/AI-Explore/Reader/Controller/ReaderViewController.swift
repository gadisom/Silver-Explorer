//
//  ReaderViewController.swift
//  MLTextAssistant
//
//  Created by Demian on 2023/07/29.
//

import UIKit

class ReaderViewController: UIViewController {
    
    @IBOutlet weak var scrollViewSub: UIView!
    @IBOutlet weak var labelBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textLabel: UILabel!
    var uiImageViews: [UIImageView] = []
    
    weak var documentDataDelegate: DocumentDataDelegate?
    var documentTexts: [String] = []
    var documentImages: [[CIImage]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let playTTS = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(playVoice(_:)))
        navigationItem.rightBarButtonItems = [playTTS]
        
        loadDocumentData()
        textLabel.text = documentTexts.first
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
        
        print(documentImages[0].count)
    }
    
    private func showImages() {
        for documentImage in documentImages.first! {
            let image = UIImage(ciImage: documentImage)
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            self.uiImageViews.append(imageView)
        }
        
        var xOffset: CGFloat = 0
        var yOffset: CGFloat = textLabel.frame.maxY + 10
        print("label maxY: \(yOffset)")
        
        for imageView in uiImageViews {
            let imageWidth = imageView.image!.size.width
            let imageHeight = imageView.image!.size.height
            
            let imageViewWidth = scrollViewSub.frame.width
            let imageViewHeight = imageViewWidth * (imageHeight / imageWidth)
            
            imageView.frame = CGRect(x: xOffset, y: yOffset, width: imageViewWidth, height: imageViewHeight)
            scrollViewSub.addSubview(imageView)
            print("yOFF: \(yOffset), Height: \(imageViewHeight)")
            
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
            
            print("sv height: \(scrollViewSub.frame.height)")
            
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
                print("img minY: \(currentImageView!.frame.minY)")
                currentImageView = nextImageView
            }
//
//            NSLayoutConstraint.activate([
//                currentImageView!.leadingAnchor.constraint(equalTo: scrollViewSub.leadingAnchor),
//                currentImageView!.widthAnchor.constraint(equalToConstant: scrollViewSub.frame.width),
////                scrollViewSub.bottomAnchor.constraint(equalTo: currentImageView!.bottomAnchor)
//            ])
            
            print("sv height: \(scrollViewSub.frame.maxY)")
        }
    }
}
