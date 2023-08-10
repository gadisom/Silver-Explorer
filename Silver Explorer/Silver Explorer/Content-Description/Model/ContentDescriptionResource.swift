//
//  DescriptionResource.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/08/09.
//

import Foundation

struct ContentDescriptionResource {
    let contentTitle: [Content: String] = [
        .UIExplore: "터치 제스처 탐험하기",
        .ARKiosk: "키오스크 탐험하기",
        .AIExplore: "AI 탐험하기",
        .none: ""
    ]
    let contentDescription: [Content: String] = [
        .UIExplore: "스마트 기기와 소통하는 다양한 방법을\nAR 캐릭터와 함께 재밌게 배워보고\n앞으로 스마트 기기들과 두려움 없이 소통해보세요!",
        .ARKiosk: "키오스크 화면을 차근차근 탐험해 보고\n키오스크를 AR로 관찰하다 보면\n어느샌가 키오스크를 두려워하지 않는\n탐험가님을 보게 될 거예요!",
        .AIExplore: "우리 삶을 더욱 편리하게 해주는\nAI 기술을 탐험해보고 앞으로\n탐험가님들에게 도움이 될 수 있는\nAI 기술들을 찾아보세요!",
        .none: ""
    ]
}
