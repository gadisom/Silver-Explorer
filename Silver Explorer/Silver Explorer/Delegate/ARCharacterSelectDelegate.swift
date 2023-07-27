//
//  ARCharacterSelectDelegate.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/27.
//

import Foundation

protocol ARCharacterDelegate: AnyObject {
    func selectedARCharacter() -> ARCharacter?
}
