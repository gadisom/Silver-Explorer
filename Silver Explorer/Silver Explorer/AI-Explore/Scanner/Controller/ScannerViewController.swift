//
//  ViewController.swift
//  MLTextAssistant
//
//  Created by Demian on 2023/07/21.
//

import Foundation
import UIKit
import CoreML
import VisionKit

class ScannerViewController: UIViewController {
    
    let documentTexts: [String]? = nil
    var documents: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
        let scannerViewController = VNDocumentCameraViewController()
        scannerViewController.delegate = self
        self.present(scannerViewController, animated: true)
        
        
        let storyboard = UIStoryboard(name: "Reader", bundle: Bundle.main)

        let nextVC = storyboard.instantiateViewController(withIdentifier: "ReaderViewController") as! ReaderViewController
        
        nextVC.documentDataDelegate = self as DocumentDataDelegate
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

}

extension ScannerViewController: VNDocumentCameraViewControllerDelegate {
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        for pageNumber in 0..<scan.pageCount {
            let docImage = scan.imageOfPage(at: pageNumber)
            documents.append(docImage)
        }

        controller.dismiss(animated: true)
    }

    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        controller.dismiss(animated: true)
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        print(error)
        controller.dismiss(animated: true)
    }
}

extension ScannerViewController: DocumentDataDelegate {
    func documentImages() -> [UIImage]? {
        return documents
    }
}
