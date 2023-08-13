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
    weak var kioskMainBoardDelegate : KioskMainBoardDelegate?
    
    func loadScene() {
        
        switch caller {
        case .membership:
            sceneName = "ARKioskBarcode.scn"
        case .paymentSelect:
            sceneName = "ARKiosk.scn"
        default:
            break
        }
        //self.sceneName = name
    }
    func appear(sender: UIViewController) {
        self.modalPresentationStyle = .overFullScreen
        sender.present(self, animated: false)
    }
    
    @IBOutlet weak var vwContainer: UIView!
    @IBAction func buttonTapped(_ sender: Any) {
        moveToNextScreen()

    }
    @IBOutlet var sceneView: ARSCNView!
    var pokeNode : SCNNode?
    
    func moveToNextScreen() {
        switch caller {
        case .membership:
            moveToPaymentSelect()  // 위에서 정의한 PaymentSelect로 이동하는 함수
        case .paymentSelect:
            moveToPaymentFinish()  // PaymentFinishViewController로 이동하는 함수, 이것도 위와 같은 방식으로 작성해야 합니다.
        case .none:
            // 에러 처리나 기본 화면으로 돌아가는 로직
            break
        }
    }
    func moveToPaymentSelect() {
        self.dismiss(animated: true)
        kioskMainBoardDelegate?.didARVCFinish()
    }
    func moveToPaymentFinish() {
        self.dismiss(animated: true)
        kioskMainBoardDelegate?.backToMainScreen()
    }
    
    // 버튼 콘테이너 애니메이션 관련 프로퍼티
    func animateButton ()
    {
        DispatchQueue.main.async {
            self.vwContainer.alpha = 0.0
            self.vwContainer.isHidden = false
            UIView.animate(withDuration: 1.5, delay: 0.5,options: .curveEaseIn, animations: {
                self.vwContainer.alpha = 1.0
            })
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadScene()
        sceneView.delegate = self
        sceneView.showsStatistics = true
        sceneView.autoenablesDefaultLighting = true
        self.vwContainer.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("djfh")
        let configuration = ARImageTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "ARKiosk", bundle: Bundle.main){
            configuration.trackingImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 1
            print("성공")
            
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
                           animateButton()
                       }
                   }
               }
        }
        
        return node
    }
 
}
