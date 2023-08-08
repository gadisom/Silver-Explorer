//
//  TTSManager.swift
//  MLTextAssistant
//
//  Created by Demian on 2023/07/31.
//

import Foundation
import AVFoundation

class TTSManager {
    static let shared = TTSManager()
    private let synthesizer = AVSpeechSynthesizer()
        
    internal func play(_ string: String) {
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        utterance.rate = 0.5
        synthesizer.stopSpeaking(at: .immediate)
        synthesizer.speak(utterance)
    }
        
    internal func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}
