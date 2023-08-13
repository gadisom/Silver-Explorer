//
//  ViewController.swift
//  AR_Kiosk
//
//  Created by 김정원 on 2023/07/23.
//

import UIKit
import SceneKit
import ARKit

class ARKioskViewController: UIViewController, ARSCNViewDelegate {
    
    var sceneName: String?
    var caller : ARCaller?
    var paymentType : PaymentType?
    
    weak var kioskMainBoardDelegate : KioskMainBoardDelegate?
    weak var arKioskDelegate: ARKioskDelegate?
    
    func loadScene() {
        switch caller {
        case .membership, .barcodePayment:
            sceneName = "ARKioskBarcode.scn"
        case .creditPayment:
            sceneName = "ARKiosk.scn"
        default:
            break
        }
    }
    func appear(sender: UIViewController) {
        self.modalPresentationStyle = .overFullScreen
        sender.present(self, animated: false)
    }
    
    @IBOutlet weak var vwContainer: UIView!

    @IBAction func buttonTapped(_ sender: UIButton) {
        self.dismiss(animated: false) {
            self.arKioskDelegate?.didARKioskFinish()
        }
    }
    
    @IBOutlet var sceneView: ARSCNView!
    var pokeNode : SCNNode?
    
    // 버튼 콘테이너 애니메이션 관련 프로퍼티
    func animateButton ()
    {
        DispatchQueue.main.async {
            self.vwContainer.alpha = 0.0
            self.vwContainer.isHidden = false
            UIView.animate(withDuration: 1.0, delay: 0.5,options: .curveEaseIn, animations: {
                self.vwContainer.alpha = 1.0
            })
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        animateButton()
        loadScene()
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
        self.vwContainer.isHidden = true
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light}
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARImageTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "ARKiosk", bundle: Bundle.main){
            configuration.trackingImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 1
        }
        sceneView.session.run(configuration)
       
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
        
    }
  
    func renderer (_ renderer : SCNSceneRenderer, nodeFor anchor: ARAnchor )-> SCNNode? {
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 1.0)
            
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi/2
            node.addChildNode(planeNode)
            
            if let sceneName = sceneName {
                   if let pokeScene = SCNScene(named: sceneName) {
                       if let pokeNode = pokeScene.rootNode.childNodes.first {
                           self.pokeNode = pokeNode
                           planeNode.addChildNode(pokeNode)
                           pokeNode.eulerAngles.x = .pi/2
                       }
                   }
               }
        }
        
        return node
    }
 
}
