//
//  ARKioskForBarcode.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/08/14.
//

import ARKit
import SceneKit

class ARKioskForBarcode: ARKioskModel {
    
    private var updatedScale: CGFloat = 0.0
    
    init(containerNode: SCNNode) {
        super.init(kioskContainerNode: containerNode, kioskNodeName: String(describing: ARKioskForBarcode.self))
    }
    
    static func makeContainerNode() -> SCNNode? {
        let node: SCNNode = SCNNode()

        guard let arKioskScene = SCNScene(named: String(describing: ARKioskForBarcode.self) + ".scn") else {
            return nil
        }
        guard let arKioskNode = arKioskScene.rootNode.childNode(withName: String(describing: ARKioskForBarcode.self), recursively: true) else {
            return nil
        }

        arKioskNode.scale = SCNVector3(0.05, 0.05, 0.09)
        
        node.addChildNode(arKioskNode)
        return node
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
        default:
            return
        }
        kioskNode.runAction(rightAngleRotatingAction)
        
    }
    @objc override func scaleUpAndDown(_ gesture: UIPinchGestureRecognizer) {
        switch gesture.state {
        case .began:
            updatedScale = CGFloat(kioskNode.scale.x)
            break
        case .changed:
            let scale = gesture.scale
            
            let scaleValue = updatedScale * scale
            
            let scaleAction = SCNAction.scale(to: scaleValue, duration: 0.0)
            kioskNode.runAction(scaleAction)
            break
        default:
            return
        }
    }
    
}
