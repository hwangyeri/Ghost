//
//  JoinModel.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/20.
//

import Foundation

// MARK: 회원 가입
struct JoinInput: Encodable {
    var email: String
    var password: String
    let nick: String
}

struct JoinOutput: Decodable {
    let _id: String
    let email: String
    let nick: String
}

// MARK: 이메일 중복 확인
struct ValidationEmailInput: Encodable {
    let email: String
}

struct ValidationEmailOutput: Decodable {
    let message: String
}

// MARK: 로그인
struct LoginInput: Encodable {
    let email: String
    let password: String
}

struct LoginOutput: Decodable {
    let _id: String
    let token: String
    let refreshToken: String
}

// MARK: AcessToken 갱신
struct RefreshOutput: Decodable {
    let token: String
}

// MARK: 회원 탈퇴
struct WithdrawOutput: Decodable {
    let _id: String
    let email: String
    let nick: String
}

