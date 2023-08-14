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
    var text: String = ""
    
    internal func setDelegate(readerVC: AVSpeechSynthesizerDelegate) {
        synthesizer.delegate = readerVC
    }
    
    internal func setText(text: String?) {
        guard let ttsText = text else { return }
        
        self.text = ttsText
    }
    
    internal func goTTS(ttsState: TTSStatusType) {
        if ttsState == .Off {
            self.play()
        }
        
        else if ttsState == .Paused {
            self.resume()
        }
        
        else if ttsState == .On {
            self.pause()
        }
    }
        
    internal func play() {
        let utterance = AVSpeechUtterance(string: self.text)
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        utterance.rate = 0.5
        synthesizer.stopSpeaking(at: .immediate)
        synthesizer.speak(utterance)
    }

    internal func pause() {
        guard synthesizer.isSpeaking else {
            return
        }
        
        if synthesizer.isPaused {
            return
        }
        
        synthesizer.pauseSpeaking(at: .immediate)
    }
    
    internal func resume() {
        guard synthesizer.isPaused else {
            return
        }
        
        synthesizer.continueSpeaking()
    }
    
    internal func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}
