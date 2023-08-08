//
//  NavigationBarButtons.swift
//  MLTextAssistant
//
//  Created by Demian on 2023/08/05.
//

import Foundation
import UIKit

extension ReaderViewController {
    @objc func setFontSize() {
        
    }
    
    @objc func playVoice(_ sender: Any) {
        TTSManager.shared.play(textLabel.text!)
    }
}
