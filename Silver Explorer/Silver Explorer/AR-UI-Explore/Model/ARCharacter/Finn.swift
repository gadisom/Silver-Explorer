//
//  Finn.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/26.
//

import ARKit
import SceneKit

// MARK: - Finn Class

class Finn: ARCharacter {
    let bodyNode: SCNNode
    private var updatedScale: CGFloat = 0.0
    
    init(finnContainerNode: SCNNode) {
        bodyNode = finnContainerNode.childNode(withName: "Finn_Body", recursively: true)!
        super.init(characterContainerNode: finnContainerNode, characterNodeName: "Finn")
        self.eulerAngleOfCharacterNode = bodyNode.eulerAngles
    }
    
    static func makeFinnContainerNode() -> SCNNode? {
        let node: SCNNode = SCNNode()
        
        guard let finnScene = SCNScene(named: "art.scnassets/Finn/Finn.scn") else {
            return nil
        }
      
        guard let finnNode = finnScene.rootNode.childNode(withName: "Finn", recursively: true) else {
            return nil
        }
        
        finnNode.transform = SCNMatrix4MakeRotation(-GLKMathDegreesToRadians(20), 1, 0, 0)
        finnNode.scale = SCNVector3(0.0007, 0.0007, 0.0007)
        
        node.addChildNode(finnNode)
        
        return node
    }
    
    // MARK: - Action Methods
    
    @objc override func jump() {
        let jumpAction = SCNAction.moveBy(x: 0, y: 0.03, z: 0, duration: 0.2)
        let fallAction = SCNAction.moveBy(x: 0, y: -0.03, z: 0, duration: 0.2)
        
        let jumpSequence = SCNAction.sequence([jumpAction, fallAction])
        
        characterNode.runAction(jumpSequence)
    }
    
    @objc override func highJump(_ gesture: UILongPressGestureRecognizer) {
        if (gesture.state == .began) {
            readyAction()
            longPressStartTime = CACurrentMediaTime()
        } else if (gesture.state == .ended) {
            let longPressEndTime = CACurrentMediaTime()
            let longPressDuration = longPressEndTime - longPressStartTime
            highJumpAction(longPressDuration: longPressDuration)
        }
    }
    
    @objc override func rightAngleRotate(_ gesture: UISwipeGestureRecognizer) {
        var rightAngleRotatingAction: SCNAction!

        switch gesture.direction {
        case .right:
            rightAngleRotatingAction = SCNAction.rotateBy(x: 0.0, y: CGFloat(GLKMathDegreesToRadians(90)) , z: 0.0, duration: 0.2)
            break
        case .left:
            rightAngleRotatingAction = SCNAction.rotateBy(x: 0.0, y: -CGFloat(GLKMathDegreesToRadians(90)) , z: 0.0, duration: 0.2)
            break
        case .up:
            rightAngleRotatingAction = SCNAction.rotateBy(x: -CGFloat(GLKMathDegreesToRadians(90)), y: 0.0 , z: 0.0, duration: 0.2)
            break
        default:
            rightAngleRotatingAction = SCNAction.rotateBy(x: CGFloat(GLKMathDegreesToRadians(90)), y: 0.0 , z: 0.0, duration: 0.2)
        }
        bodyNode.runAction(rightAngleRotatingAction)
    }
    
    @objc override func eulerAngleRotate(_ gesture: UIPanGestureRecognizer) {
        
        if (gesture.state == .ended || gesture.state == .cancelled) {
            resetARCharacterAngle(targetNode: bodyNode)
        } else {
            let translation = gesture.translation(in: sceneView)
            
            let rotationAngleX = CGFloat(translation.x) * 0.001
            let rotationAngleY = CGFloat(translation.y) * 0.001
            
            let yRotation = SCNAction.rotateBy(x: 0, y: rotationAngleX, z: 0, duration: 0)
            let xRotation = SCNAction.rotateBy(x: rotationAngleY, y: 0, z: 0, duration: 0)
            
            bodyNode.runAction(yRotation)
            bodyNode.runAction(xRotation)
        }
    }
    
    @objc override func scaleUpAndDown(_ gesture: UIPinchGestureRecognizer) {
        switch gesture.state {
        case .began:
            updatedScale = CGFloat(characterNode.scale.x)
            break
        case .changed:
            let scale = gesture.scale
            
            let scaleValue = updatedScale * scale
            
            // Animate the scaling using SCNAction
            let scaleAction = SCNAction.scale(to: scaleValue, duration: 0.0)
            characterNode.runAction(scaleAction)
            break
        default:
            return
        }
    }
    
    @objc override func zAxisRotate(_ gesture: UIRotationGestureRecognizer) {
        if (gesture.state == .changed) {
            let rotationAngle = gesture.rotation
            let degrees = -GLKMathRadiansToDegrees(Float(rotationAngle) * 0.005)
            let rotationAction = SCNAction.rotateBy(x: 0, y: 0, z: CGFloat(degrees), duration: 0.0)
            bodyNode.runAction(rotationAction)
        }
    }

    // MARK: - highJump Feature Methods

    private func readyAction() {
        let scaleAction = SCNAction.customAction(duration: 0.0) {
            (_, _) in
            self.characterNode.scale = SCNVector3(self.initialScale, self.initialScale - 0.0002, self.initialScale)
        }
        characterNode.runAction(scaleAction)
    }
    
    private func highJumpAction(longPressDuration: CFTimeInterval) {
        let scaleAction = SCNAction.customAction(duration: 0.0) {
            (_, _) in
            self.characterNode.scale = SCNVector3(self.initialScale, self.initialScale, self.initialScale)
        }
        let jumpHeight = CGFloat(longPressDuration) * 0.1
        let jumpAction = SCNAction.moveBy(x: 0, y: jumpHeight, z: 0, duration: 0.2)
        let fallAction = SCNAction.moveBy(x: 0, y: -jumpHeight, z: 0, duration: 0.2)
        let jumpSequence = SCNAction.sequence([scaleAction, jumpAction, fallAction])

        characterNode.runAction(jumpSequence)
    }
    
}
