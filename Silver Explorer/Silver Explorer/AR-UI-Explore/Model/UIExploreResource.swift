//
//  UIExploreResource.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/26.
//

import ARKit
import SceneKit

enum Stage: Int {
    case shortTap = 0, longTap, swipe, drag, pinch, rotate
}

struct UIExploreResource {
    var stageTitles: [String] {
        return [
            "탭하기 - 짧게", "탭하기 - 길게", "스와이프하기", "드래그하기", "확대하기/축소하기", "회전시키기"
        ]
    }
    var stageImages: [Stage: UIImage] {
        return [
            .shortTap: #imageLiteral(resourceName: "tap"),
            .longTap: #imageLiteral(resourceName: "longTap"),
            .swipe: #imageLiteral(resourceName: "swipe right"),
            .drag: #imageLiteral(resourceName: "drag"),
            .pinch: #imageLiteral(resourceName: "pinch out"),
            .rotate: #imageLiteral(resourceName: "rotate")
        ]
    }
    var stageDescriptions: [Stage: String] {
        return [
            .shortTap: "한 손가락을 사용해\nAR 캐릭터를 짧게 탭해보세요!",
            .longTap: "한 손가락을 사용해\nAR 캐릭터를 길게 탭해보세요!",
            .swipe: "한 손가락을 사용해\nAR 캐릭터를 스와이프해보세요!",
            .drag: "한 손가락을 사용해\nAR 캐릭터를 드래그해보세요!",
            .pinch: "두 손가락을 사용해\nAR 캐릭터를 확대/축소해보세요!",
            .rotate: "두 손가락을 사용해\nAR 캐릭터를 회전시켜보세요!"
        ]
    }
    private var UIGesture: UIGestureRecognizer!
    private var allSwipeGesture: [UIGestureRecognizer] = []
    
    // MARK: Add GestureRecognizer Methods
    
    mutating func addNewGestureRecognizer(stage: Stage, arCharacter: ARCharacter, sceneView: ARSCNView, swipeDirection: UISwipeGestureRecognizer.Direction) {
        switch stage {
        case .shortTap:
            addTapGestureRecognizer(targetCharacter: arCharacter, handler: #selector(arCharacter.jump), sceneView: sceneView)
            break
        case .longTap:
            addLongPressGestureRecognizer(targetCharacter: arCharacter, handler: #selector(arCharacter.highJump), sceneView: sceneView)
            break
        case .swipe:
            addSwipeGestureRecognizer(targetCharacter: arCharacter, handler: #selector(arCharacter.rightAngleRotate), sceneView: sceneView, swipeDirection: swipeDirection)
        case .drag:
            addPanGestureRecognizer(targetCharacter: arCharacter, handler: #selector(arCharacter.eulerAngleRotate), sceneView: sceneView)
            break
        case .pinch:
            addPinchGestureRecognizer(targetCharacter: arCharacter, handler: #selector(arCharacter.scaleUpAndDown), sceneView: sceneView)
        case .rotate:
            addRotationGestureRecognizer(targetCharacter: arCharacter, handler: #selector(arCharacter.zAxisRotate), sceneView: sceneView)
            break
        }
    }
    
    // MARK: - GestureRecognizer Feature Methods
    
    private mutating func addTapGestureRecognizer(targetCharacter: Any, handler action: Selector?, sceneView: ARSCNView) {
        let tapGesture = UITapGestureRecognizer(target: targetCharacter, action: action)
        
        sceneView.addGestureRecognizer(tapGesture)
        self.UIGesture = tapGesture
    }
    
    private mutating func addLongPressGestureRecognizer(targetCharacter: Any, handler action: Selector?, sceneView: ARSCNView) {
        let longPressGesture = UILongPressGestureRecognizer(target: targetCharacter, action: action)
        
        longPressGesture.minimumPressDuration = 0.1
        sceneView.addGestureRecognizer(longPressGesture)
        self.UIGesture = longPressGesture
    }
    
    private mutating func addSwipeGestureRecognizer(targetCharacter: Any, handler action: Selector?, sceneView: ARSCNView, swipeDirection: UISwipeGestureRecognizer.Direction) {
        let leftSwipeGesture = UISwipeGestureRecognizer(target: targetCharacter, action: action)
        let rightSwipeGesture = UISwipeGestureRecognizer(target: targetCharacter, action: action)
        let upSwipeGesture = UISwipeGestureRecognizer(target: targetCharacter, action: action)
        let downSwipeGesture = UISwipeGestureRecognizer(target: targetCharacter, action: action)
        
        leftSwipeGesture.direction = .left
        rightSwipeGesture.direction = .right
        upSwipeGesture.direction = .up
        downSwipeGesture.direction = .down
        sceneView.addGestureRecognizer(leftSwipeGesture)
        sceneView.addGestureRecognizer(rightSwipeGesture)
        sceneView.addGestureRecognizer(upSwipeGesture)
        sceneView.addGestureRecognizer(downSwipeGesture)
        self.allSwipeGesture.append(leftSwipeGesture)
        self.allSwipeGesture.append(rightSwipeGesture)
        self.allSwipeGesture.append(upSwipeGesture)
        self.allSwipeGesture.append(downSwipeGesture)
    }
    
    private mutating func addPanGestureRecognizer(targetCharacter: Any, handler action: Selector?, sceneView: ARSCNView) {
        let panGesture = UIPanGestureRecognizer(target: targetCharacter, action: action)

        sceneView.addGestureRecognizer(panGesture)
        self.UIGesture = panGesture
    }
    
    private mutating func addPinchGestureRecognizer(targetCharacter: Any, handler action: Selector?, sceneView: ARSCNView) {
        let pinchGesture = UIPinchGestureRecognizer(target: targetCharacter, action: action)
        
        sceneView.addGestureRecognizer(pinchGesture)
        self.UIGesture = pinchGesture
    }
    
    private mutating func addRotationGestureRecognizer(targetCharacter: Any, handler action: Selector?, sceneView: ARSCNView) {
        let rotationGesture = UIRotationGestureRecognizer(target: targetCharacter, action: action)
        
        sceneView.addGestureRecognizer(rotationGesture)
        self.UIGesture = rotationGesture
    }
    
    
    // MARK: - Remove GestureRecognizer Methods
    
    mutating func removeGestureRecognizer(sceneView: ARSCNView, stage: Stage) {
        if (stage == .swipe) {
            for i in 0..<allSwipeGesture.count {
                sceneView.removeGestureRecognizer(allSwipeGesture[i])
            }
            allSwipeGesture.removeAll()
        } else {
            sceneView.removeGestureRecognizer(UIGesture)            
        }
    }
}
