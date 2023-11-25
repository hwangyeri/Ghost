//
//  APIErrors.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/21.
//

import Foundation

enum APIError: Int, Error {
    
    case unknownError = 1
    case decodedError = 2
    
    ///공통 응답 코드 (HTTP status code)
    case missingSesacKey = 420
    case overcall = 429
    case invalidURL = 444
    case undefined = 500
    
    case invalidRequest = 400 ///잘못된 요청(포스트), 필수값 누락(회원가입, 이메일 중복 확인)
    case alreadyExists = 409 ///이미 가입한 유저(회원가입), 사용 불가한 이메일(이메일 중복 확인), 액세스 토큰 만료 후 재요청(액세스 토큰 갱신)
    case unusableAccount = 401 ///미가입이나 비밀번호 불일치(로그인), 유효하지 않은 액세스 토큰
    case forbidden = 403
    case refreshTokenExpired = 418
    case accessTokenExpired = 419
    case missingPost = 410
    case unauthorized = 445
    
    var errorDescription: String {
        switch self {
        case .unknownError:
            return "알 수 없는 에러가 발생했습니다."
        case .decodedError:
            return "디코딩에 실패했습니다."
        case .missingSesacKey:
            return "SesacKey가 잘못되었습니다."
        case .overcall:
            return "서버 과호출입니다."
        case .invalidURL:
            return "비정상적인 URL입니다."
        case .undefined:
            return "알 수 없는 에러가 발생했습니다."
        case .invalidRequest:
            return "잘못된 요청입니다."
        case .alreadyExists:
            return "이미 존재하는 이메일입니다."
        case .unusableAccount:
            return "사용할 수 없는 계정입니다."
        case .forbidden:
            return "접근 권한이 없습니다."
        case .refreshTokenExpired:
            return "리프레시 토큰이 만료되었습니다. 다시 로그인 해주세요."
        case .accessTokenExpired:
            return "액세스 토큰이 만료되었습니다."
        case .missingPost:
            return "생성된 게시글이 없습니다."
        case .unauthorized:
            return "수정/삭제 권한이 없습니다."
        }
    }
}
