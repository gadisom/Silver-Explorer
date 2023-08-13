//
//  PhoneNumberMembershipDelegate.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/08/12.
//

import Foundation

protocol PhoneNumberMembershipDelegate: AnyObject {
    func isValidPhoneNumber() -> Bool
}
