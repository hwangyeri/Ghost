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
    case refresh // AcessToken 갱신
    case withdraw // 탈퇴
}

extension PostAPI: TargetType {
    
    //서버의 도메인
    var baseURL: URL {
        return URL(string: APIKey.baseURL)!
    }
    
    //서버의 도메인 뒤에 추가 될 경로 (일반적으로 API)
    var path: String {
        switch self {
        case .join:
            return "join"
        case .validationEmail:
            return "validation/email"
        case .login:
            return "login"
        case .refresh:
            return "refresh"
        case .withdraw:
            return "refresh"
        }
    }
    
    //HTTP method
    var method: Moya.Method {
        switch self {
        case .join, .validationEmail, .login:
            return .post
        case .refresh, .withdraw:
            return .get
        }
    }
    
    //request에 사용되는 파라미터 설정
    var task: Moya.Task {
        switch self {
        case .join(let model):
            return .requestJSONEncodable(model)
        case .validationEmail(let model):
            return .requestJSONEncodable(model)
        case .login(let model):
            return .requestJSONEncodable(model)
        case .refresh, .withdraw:
            return .requestPlain
        }
    }
    
    //HTTP header
    var headers: [String : String]? {
        switch self {
        case .join, .validationEmail, .login:
            ["Content-Type": "application/json",
             "SesacKey": APIKey.sesacKey]
        case .refresh:
            ["Authorization": "\(KeychainManager.shared.token ?? "token error")",
             "SesacKey": APIKey.sesacKey,
             "Refresh": "\(KeychainManager.shared.refreshToken ?? "refreshToken error")"]
        case .withdraw:
            ["Authorization": "\(KeychainManager.shared.token ?? "token error")",
             "SesacKey": APIKey.sesacKey]
        }
    }
    
    //허용할 response의 타입
    var validationType: ValidationType {
        return .successCodes
    }
    
}
