//
//  ARCharacter.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/26.
//

import ARKit
import SceneKit

// MARK: - ARCharacter Class
class ARCharacter {
    var sceneView: ARSCNView!
    var characterContainerNode: SCNNode
    var characterNode: SCNNode
    var eulerAngleOfCharacterNode: SCNVector3
    var longPressStartTime: CFTimeInterval = 0.0
    var initialScale: CGFloat

    init(characterContainerNode: SCNNode, characterNodeName: String) {
        self.characterContainerNode = characterContainerNode
        self.characterNode = characterContainerNode.childNode(withName: characterNodeName, recursively: true)!
        self.eulerAngleOfCharacterNode = characterNode.eulerAngles
        self.initialScale = CGFloat(characterNode.scale.x)
    }

    final func setSceneView(sceneView: ARSCNView) { self.sceneView = sceneView }

    @objc func jump() {}
    @objc func highJump(_ gesture: UILongPressGestureRecognizer) {}
    @objc func rightAngleRotate(_ gesture: UISwipeGestureRecognizer) {}
    @objc func eulerAngleRotate(_ gesture: UIPanGestureRecognizer) {}
    @objc func scaleUpAndDown(_ gesture: UIPinchGestureRecognizer) {}
    @objc func zAxisRotate(_ gesture: UIRotationGestureRecognizer) {}
    
    func resetARCharacterAngle(targetNode: SCNNode) {
        let resetAngleAction = SCNAction.rotateTo(x: CGFloat(eulerAngleOfCharacterNode.x), y: CGFloat(eulerAngleOfCharacterNode.y), z: CGFloat(eulerAngleOfCharacterNode.z), duration: 0.2)
        
        targetNode.runAction(resetAngleAction)
    }
    
    func resetARCharacterScale() {
        let resetScaleAction = SCNAction.customAction(duration: 0.2) { (_, _) in
            self.characterNode.scale = SCNVector3(self.initialScale, self.initialScale, self.initialScale)
        }
        
        characterNode.runAction(resetScaleAction)
    }
}
