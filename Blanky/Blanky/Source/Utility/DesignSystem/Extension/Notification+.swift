//
//  Notification+.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/27.
//

import Foundation

enum AppNotification: String {
    case joinSuccessAlert
    case tokenRefreshFailedAlert
}

extension NSNotification.Name {
    
    // 회원가입 성공시 루트 뷰(로그인 화면)로 화면 전환 -> 알럿
    static let joinSuccessAlert = NSNotification.Name(AppNotification.joinSuccessAlert.rawValue)
    
    // 액세스 토큰 만료시 갱신 실패(418) -> 로그인 화면으로 전환 후 알럿
    static let tokenRefreshFailedAlert = NSNotification.Name(AppNotification.tokenRefreshFailedAlert.rawValue)
    
}
