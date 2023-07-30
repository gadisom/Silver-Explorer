//
//  KioskModalResource.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/30.
//

import Foundation

struct KioskModalResource {
    let modalTitles: [KioskModalContent: String] = [
        .option: "옵션 선택",
        .membership: "은빛 탐험 스탬프 적립",
        .paymentSelect: "결제 방법 선택",
        .creditCardPayment: "신용카드 결제",
        .barcodePayment: "할인/바코드 결제",
        .success: "결제 완료"
    ]
    
    let modalButtonText: [KioskModalContent: [String]] = [
        .option: ["취소", "담기"],
        .membership: ["건너뛰기", "적립"],
        .paymentSelect: ["이전", "결제하기"],
        .creditCardPayment: ["AR로 위치 확인하기"],
        .barcodePayment: ["AR로 위치 확인하기"]
    ]
    
}
