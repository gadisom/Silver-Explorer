//
//  ARCharacterSelectViewController.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/27.
//

import UIKit
import SceneKit

class ARCharacterSelectViewController: UIViewController, ARCharacterDelegate {

    var characterNum: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func pushedArrButton(_ sender: UIButton) {
        self.characterNum = 0
        moveToUIExploreVC(vc: self)
    }
    @IBAction func pushedDogButton(_ sender: UIButton) {
        self.characterNum = 1
        moveToUIExploreVC(vc: self)
    }

    // MARK: - ARCharacterDelegae 필수 메서드
    func selectedARCharacter() -> ARCharacter? {
        if (self.characterNum == 0) {
            guard let containerNode: SCNNode = Arr.makeArrContainerNode() else {
                return nil
            }
            return Arr(arrContainerNode: containerNode)
        } else {
            guard let containerNode: SCNNode = Finn.makeFinnContainerNode() else {
                return nil
            }
            return Finn(finnContainerNode: containerNode)
        }
    }
}
