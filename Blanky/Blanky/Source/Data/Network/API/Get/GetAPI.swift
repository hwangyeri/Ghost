//
//  GetAPI.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/21.
//

import Foundation
import Moya

enum GetAPI: String {
    case refresh // AcessToken 갱신
    case withdraw // 탈퇴
}

extension GetAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: APIKey.baseURL)!
    }
    
    var path: String {
        switch self {
        case .refresh, .withdraw:
            return rawValue
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .refresh, .withdraw:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .refresh, .withdraw:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .refresh:
            ["Authorization": "\(KeychainManager.shared.token ?? "token error")",
             "SesacKey": APIKey.sesacKey,
             "Refresh": "\(KeychainManager.shared.refreshToken ?? "refreshToken error")"]
        case .withdraw:
            ["Authorization": "\(KeychainManager.shared.token ?? "token error")",
             "SesacKey": APIKey.sesacKey]
        }
    }
    
}
