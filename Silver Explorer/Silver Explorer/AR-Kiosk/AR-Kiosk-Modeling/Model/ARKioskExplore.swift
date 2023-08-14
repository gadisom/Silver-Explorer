//
//  ARKioskExplore.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/08/14.
//

import UIKit
import ARKit
import SceneKit

struct ARKioskExplore {
    func addSwipeGestureRecognizer(targetCharacter: ARKioskModel, handler action: Selector?, sceneView: ARSCNView) {
        let leftSwipeGesture = UISwipeGestureRecognizer(target: targetCharacter, action: action)
        let rightSwipeGesture = UISwipeGestureRecognizer(target: targetCharacter, action: action)
        
        leftSwipeGesture.direction = .left
        rightSwipeGesture.direction = .right
        sceneView.addGestureRecognizer(leftSwipeGesture)
        sceneView.addGestureRecognizer(rightSwipeGesture)
    }
    
    func addPinchGestureRecognizer(targetCharacter: ARKioskModel, handler action: Selector?, sceneView: ARSCNView) {
        let pinchGesture = UIPinchGestureRecognizer(target: targetCharacter, action: action)
        
        sceneView.addGestureRecognizer(pinchGesture)
    }
}
