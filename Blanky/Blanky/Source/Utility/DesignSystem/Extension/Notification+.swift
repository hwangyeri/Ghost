//
//  Notification+.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/27.
//

import Foundation

enum AppNotification: String {
    case joinSuccessAlert
}

extension NSNotification.Name {
    
    //회원가입 성공시 루트 뷰로 화면 전환 -> 알럿
    static let joinSuccessAlert = NSNotification.Name(AppNotification.joinSuccessAlert.rawValue)
    
}
