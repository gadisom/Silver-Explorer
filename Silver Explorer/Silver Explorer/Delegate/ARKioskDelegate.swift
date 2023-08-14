//
//  ARKioskDelegate.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/08/13.
//

import Foundation

protocol ARKioskDelegate: AnyObject {
    func selectedARKiosk() -> ARKioskModel?
    func didARKioskFinish()
}
