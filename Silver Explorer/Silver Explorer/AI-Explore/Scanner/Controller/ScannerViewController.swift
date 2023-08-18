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
    var viewControllers: [UIViewController]!
    var viewControllersCount: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scan()
    }
    
    func scan() {
        viewControllers = self.navigationController!.viewControllers as [UIViewController]
        viewControllersCount = viewControllers.count
        
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
        documents.removeAll()
        guard scan.pageCount > 0 else {
            controller.dismiss(animated: true)
            self.navigationController?.popToRootViewController(animated: true)
            return
        }
        let documentImage = scan.imageOfPage(at: 0)
        documents.append(documentImage)

        controller.dismiss(animated: true)
    }

    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        controller.dismiss(animated: true)
        self.navigationController?.popToViewController(viewControllers[viewControllersCount - 2], animated: true)
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        print(error)
        controller.dismiss(animated: true)
        self.navigationController?.popToViewController(viewControllers[viewControllersCount - 2], animated: true)
    }
}

extension ScannerViewController: DocumentDataDelegate {
    func documentImages() -> [UIImage]? {
        return documents
    }
}
