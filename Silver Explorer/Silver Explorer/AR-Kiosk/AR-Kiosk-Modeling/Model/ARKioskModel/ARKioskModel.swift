//
//  ARKiosk.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/08/14.
//

import ARKit
import SceneKit

// MARK: - ARKiosk Class

class ARKioskModel {
    var sceneView: ARSCNView!
    var kioskContainerNode: SCNNode
    var kioskNode: SCNNode

    init(kioskContainerNode: SCNNode, kioskNodeName: String) {
        self.kioskContainerNode = kioskContainerNode
        self.kioskNode = kioskContainerNode.childNode(withName: kioskNodeName, recursively: true)!
    }

    final func setSceneView(sceneView: ARSCNView) { self.sceneView = sceneView }

    @objc func rightAngleRotate(_ gesture: UISwipeGestureRecognizer) {}
    @objc func scaleUpAndDown(_ gesture: UIPinchGestureRecognizer) {}
}
