//
//  ReaderResource.swift
//  Silver Explorer
//
//  Created by Demian on 2023/08/09.
//

import Foundation
import UIKit

struct ReaderResource {
    
    let fontSize: [FontSizeType: CGFloat] = [
        .Normal: 32,
        .Large: 40
    ]
    
    let fontButtonText: [FontSizeType: String] = [
        .Normal: "글씨 키우기",
        .Large: "원래대로"
    ]
    
    let ttsButtonText: [TTSStatusType: String] = [
        .On: "일시정지",
        .Off: "읽어주기",
        .Paused: "계속읽기"
    ]
    
    let buttonFont = UIFont.systemFont(ofSize: 22, weight: .semibold)
}

enum FontSizeType {
    case Normal
    case Large
}

enum TTSStatusType {
    case On
    case Paused
    case Off
}
