//
//  GetModel.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/21.
//

import Foundation

// MARK: AcessToken 갱신
struct RefreshOutput: Decodable {
    let token: String
}

// MARK: 회원 탈퇴
struct WithdrawOutput: Decodable {
    let id: String
    let email: String
    let nick: String
}

