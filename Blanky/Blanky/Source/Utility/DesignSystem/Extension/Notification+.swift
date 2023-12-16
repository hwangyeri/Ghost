//
//  Notification+.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/27.
//

import Foundation

enum AppNotification: String {
    case joinSuccessAlert
    case postSuccessAlert
}

extension NSNotification.Name {
    
    // 회원가입 성공시 루트뷰(로그인 화면)로 화면 전환 -> 알럿
    static let joinSuccessAlert = NSNotification.Name(AppNotification.joinSuccessAlert.rawValue)
    
    // 게시글 작성 성공시 루트뷰(홈 화면)로 화면 전환 -> 알럿
    static let postSuccessAlert = NSNotification.Name(AppNotification.postSuccessAlert.rawValue)
    
}
