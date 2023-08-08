//
//  DocumentDataDelegate.swift
//  MLTextAssistant
//
//  Created by Demian on 2023/07/29.
//

import Foundation
import UIKit

protocol DocumentDataDelegate: AnyObject {
    func documentImages() -> [UIImage]?
}
