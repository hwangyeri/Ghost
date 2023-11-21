//
//  PostAPI.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/20.
//

import Foundation
import Moya

enum PostAPI {
    case join(model: JoinInput) // 회원가입
    case validationEmail(model: ValidationEmailInput) // 이메일 중복 확인
    case login(model: LoginInput) // 로그인
}

extension PostAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: APIKey.baseURL)!
    }
    
    var path: String {
        switch self {
        case .join:
            return "join"
        case .validationEmail:
            return "validation/email"
        case .login:
            return "login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .join, .validationEmail, .login:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .join(let model):
            return .requestJSONEncodable(model)
        case .validationEmail(let model):
            return .requestJSONEncodable(model)
        case .login(let model):
            return .requestJSONEncodable(model)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .join, .validationEmail, .login:
            ["Content-Type": "application/json",
             "SesacKey": APIKey.sesacKey]
        }
    }
    
}
