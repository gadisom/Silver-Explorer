//
//  UIExploreResource.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/26.
//

import ARKit
import SceneKit

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
    
    mutating func addNewGestureRecognizer(stage: Stage, arCharacter: ARCharacter, targetView: UIView) {
        switch stage {
        case .shortTap:
            addTapGestureRecognizer(targetCharacter: arCharacter, targetView: targetView, handler: #selector(arCharacter.jump))
            break
        case .longTap:
            addLongPressGestureRecognizer(targetCharacter: arCharacter, targetView: targetView, handler: #selector(arCharacter.highJump))
            break
        case .swipe:
            addSwipeGestureRecognizer(targetCharacter: arCharacter, targetView: targetView, handler: #selector(arCharacter.rightAngleRotate))
        case .drag:
            addPanGestureRecognizer(targetCharacter: arCharacter, targetView: targetView, handler: #selector(arCharacter.eulerAngleRotate))
            break
        case .pinch:
            addPinchGestureRecognizer(targetCharacter: arCharacter, targetView: targetView, handler: #selector(arCharacter.scaleUpAndDown))
        case .rotate:
            addRotationGestureRecognizer(targetCharacter: arCharacter, targetView: targetView, handler: #selector(arCharacter.zAxisRotate))
            break
        }
    }
    
    // MARK: - GestureRecognizer Feature Methods
    
    private mutating func addTapGestureRecognizer(targetCharacter: Any, targetView: UIView, handler action: Selector?) {
        let tapGesture = UITapGestureRecognizer(target: targetCharacter, action: action)
        
        targetView.addGestureRecognizer(tapGesture)
        self.UIGesture = tapGesture
    }
    
    private mutating func addLongPressGestureRecognizer(targetCharacter: Any, targetView: UIView, handler action: Selector?) {
        let longPressGesture = UILongPressGestureRecognizer(target: targetCharacter, action: action)
        
        longPressGesture.minimumPressDuration = 0.1
        targetView.addGestureRecognizer(longPressGesture)
        self.UIGesture = longPressGesture
    }
    
    private mutating func addSwipeGestureRecognizer(targetCharacter: Any, targetView: UIView, handler action: Selector?) {
        let leftSwipeGesture = UISwipeGestureRecognizer(target: targetCharacter, action: action)
        let rightSwipeGesture = UISwipeGestureRecognizer(target: targetCharacter, action: action)
        let upSwipeGesture = UISwipeGestureRecognizer(target: targetCharacter, action: action)
        let downSwipeGesture = UISwipeGestureRecognizer(target: targetCharacter, action: action)
        
        leftSwipeGesture.direction = .left
        rightSwipeGesture.direction = .right
        upSwipeGesture.direction = .up
        downSwipeGesture.direction = .down
        targetView.addGestureRecognizer(leftSwipeGesture)
        targetView.addGestureRecognizer(rightSwipeGesture)
        targetView.addGestureRecognizer(upSwipeGesture)
        targetView.addGestureRecognizer(downSwipeGesture)
        self.allSwipeGesture.append(leftSwipeGesture)
        self.allSwipeGesture.append(rightSwipeGesture)
        self.allSwipeGesture.append(upSwipeGesture)
        self.allSwipeGesture.append(downSwipeGesture)
    }
    
    private mutating func addPanGestureRecognizer(targetCharacter: Any, targetView: UIView, handler action: Selector?) {
        let panGesture = UIPanGestureRecognizer(target: targetCharacter, action: action)

        targetView.addGestureRecognizer(panGesture)
        self.UIGesture = panGesture
    }
    
    private mutating func addPinchGestureRecognizer(targetCharacter: Any, targetView: UIView, handler action: Selector?) {
        let pinchGesture = UIPinchGestureRecognizer(target: targetCharacter, action: action)
        
        targetView.addGestureRecognizer(pinchGesture)
        self.UIGesture = pinchGesture
    }
    
    private mutating func addRotationGestureRecognizer(targetCharacter: Any, targetView: UIView, handler action: Selector?) {
        let rotationGesture = UIRotationGestureRecognizer(target: targetCharacter, action: action)
        
        targetView.addGestureRecognizer(rotationGesture)
        self.UIGesture = rotationGesture
    }
    
    
    // MARK: - Remove GestureRecognizer Methods
    
    mutating func removeGestureRecognizer(targetView: UIView, stage: Stage) {
        if (stage == .swipe) {
            for i in 0..<allSwipeGesture.count {
                targetView.removeGestureRecognizer(allSwipeGesture[i])
            }
            allSwipeGesture.removeAll()
        } else {
            targetView.removeGestureRecognizer(UIGesture)
        }
    }
}
