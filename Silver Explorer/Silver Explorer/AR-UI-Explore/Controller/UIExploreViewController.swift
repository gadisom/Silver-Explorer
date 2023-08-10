//
//  UIExploreViewController.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/26.
//

import UIKit
import SceneKit
import ARKit

class UIExploreViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet private var sceneView: ARSCNView!
    @IBOutlet private var stageTitleLabel: UILabel!
    @IBOutlet private weak var stageDescriptionView: UIVisualEffectView!
    @IBOutlet private weak var stageDescriptionLabel: UILabel!
    @IBOutlet private weak var titleView: UIView!
    @IBOutlet private weak var previousBtnView: UIView!
    @IBOutlet private weak var nextBtnView: UIView!
    @IBOutlet private weak var stageImageView: UIImageView!
    
    private var stage: Stage = .shortTap
    private var swipeDirection: UISwipeGestureRecognizer.Direction = .right
    
    // 선택된 AR 캐릭터 관련 프로퍼티
    weak var arCharacterDelegate: ARCharacterDelegate?
    private var arCharacter: ARCharacter!
    
    // UIExplorer 리소스 관련 프로퍼티
    private var uiExplorer: UIExploreResource = UIExploreResource()
    private var stageTitleList: [String] {
        return uiExplorer
            .stageTitles
    }
    private var stageImages: [Stage: UIImage] {
        return uiExplorer.stageImages
    }
    private var stageDescriptionList: [Stage: String] {
        return uiExplorer.stageDescriptions
    }
    
    // MARK: - View LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
        
        setARCharacter()

        uiExplorer.addNewGestureRecognizer(
            stage: stage,
            arCharacter: self.arCharacter,
            sceneView: self.sceneView,
            swipeDirection: self.swipeDirection
        )

        makeCornerRoundShape(targetView: titleView, cornerRadius: 10)
        makeCornerRoundShape(targetView: previousBtnView, cornerRadius: 10)
        makeCornerRoundShape(targetView: nextBtnView, cornerRadius: 10)
        makeCornerRoundShape(targetView: stageDescriptionView, cornerRadius: 40)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARImageTrackingConfiguration()
        
        guard let trackingImage = ARReferenceImage.referenceImages(inGroupNamed: "Explore Ticket", bundle: Bundle.main) else {
            print("HI")
            return
        }
        
        configuration.trackingImages = trackingImage
        configuration.maximumNumberOfTrackedImages = 1

        sceneView.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
   
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
       guard let imageAnchor = anchor as? ARImageAnchor else {
           return nil
       }
       
       if imageAnchor.referenceImage.name == "card1" {
           return arCharacter.characterContainerNode
       }
       
       return nil
   }
    
    // MARK: - Move Stage IBAction Methods
    
    @IBAction private func moveNextStage(_ sender: UIButton) {
        if (stage == .rotate) {
            self.navigationController?.popViewController(animated: true)
        } else {
            resetARCharacter()
            moveStage(isNext: true)
            stageTitleLabel.text = stageTitleList[stage.rawValue]
        }
    }

    @IBAction private func moveBackStage(_ sender: UIButton) {
        if (stage == .shortTap) {
            self.navigationController?.popViewController(animated: true)
        } else {
            resetARCharacter()
            moveStage(isNext: false)
            stageTitleLabel.text = stageTitleList[stage.rawValue]
        }
    }
    
    // MARK: - Description View Gesture Recognizer Method
    
    @IBAction private func descriptionViewTouched(_ sender: UITapGestureRecognizer) {
        self.stageDescriptionView.isHidden = true
    }
    
    // MARK: - Feature Methods
    
    private func setARCharacter() {
        guard let character = arCharacterDelegate?.selectedARCharacter() else {
//            return moveBacktoHome(vc: self)
            return
        }
        self.arCharacter = character
        self.arCharacter.setSceneView(sceneView: sceneView)
    }
    
    private func resetARCharacter() {
        if (stage == .swipe || stage == .rotate) {
            if (arCharacter is Finn) {
                let finnBodyNode = (arCharacter as! Finn).bodyNode
                arCharacter.resetARCharacterAngle(targetNode: finnBodyNode)
            } else {
                arCharacter.resetARCharacterAngle(targetNode: arCharacter.characterNode)
            }
        } else if (stage == .pinch) {
            arCharacter.resetARCharacterScale()
        }
    }
            
    private func moveStage(isNext: Bool) {
        uiExplorer.removeGestureRecognizer(sceneView: sceneView, stage: stage)
    
        switch stage {
        case .shortTap:
            stage = .longTap
            break
        case .longTap:
            stage = isNext ? .swipe : .shortTap
            break
        case .swipe:
            stage = isNext ? .drag : .longTap
            break
        case .drag:
            stage = isNext ? .pinch : .swipe
            break
        case .pinch:
            stage = isNext ? .rotate : .drag
            break
        case .rotate:
            stage = .pinch
            break
        }

        uiExplorer.addNewGestureRecognizer(
            stage: stage,
            arCharacter: self.arCharacter,
            sceneView: self.sceneView,
            swipeDirection: self.swipeDirection
        )
        stageImageView.image = stageImages[self.stage]!
        stageDescriptionLabel.text = stageDescriptionList[self.stage]!
        stageDescriptionView.isHidden = false
    }

}
