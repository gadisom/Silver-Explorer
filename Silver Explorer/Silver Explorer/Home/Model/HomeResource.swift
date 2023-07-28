//
//  HomeResource.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/26.
//

import Foundation

enum Content: String {
    case UIExplore, ARKiosk, AIExplore
}

struct HomeResourse {
    let storyBoardIDs: [Content: String] = [
        .UIExplore: "ARCharacterSelectViewController",
        .ARKiosk: "ARKioskViewController"
    ]
}
