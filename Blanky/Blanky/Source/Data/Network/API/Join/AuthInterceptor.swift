//
//  AuthInterceptor.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/10.
//

import Foundation
import Alamofire
import RxSwift

final class AuthInterceptor: RequestInterceptor { // == RequestAdapter, RequestRetrier 채택
    
    static let shared = AuthInterceptor()
    
    private init() {}
    
    let disposeBag = DisposeBag()
    
    /*
     RequestInterceptor: 네트워크 요청에 대한 응답을 가로채고 처리하는 기능
     - adapt와 retry는 별도의 호출없이 생성만 해두면 자동으로 호출됨
     - adapt를 통해 보낸 API가 실패일 경우 -> retry 구문을 타게 됨
     
     로그인 API - 액세스 토큰, 리프레시 토큰 발급
     AcessToken 갱신 - Request Header로 AcessToken, refreshToken 필요 / Output - 액세스 토큰
     모든 API Request Header로 AcessToken 필요
     액세스 토큰 만료 -> 재발급 -> 실패시 로그인 화면으로 전환
     */
    
    
    // 네트워크 호출 시, 서버로 보내기 전에 API를 가로채 전처리한 뒤 서버로 보내는 역할
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print(#function, "adapt 진입")
        
        // 요청의 URL이 기대한 URL 문자열 및 액세스 토큰과 리프레시 토큰이 있는지 확인
        guard urlRequest.url?.absoluteString.hasPrefix(APIKey.baseURL) == true,
              let accessToken = KeychainManager.shared.token, let refreshToken = KeychainManager.shared.refreshToken else {
            
            // 조건이 충족되지 않으면 수정되지 않은 원래의 요청으로 완료
            completion(.success(urlRequest))
            return
        }
        
        var urlRequest = urlRequest
        
        // 액세스 및 리프레시 토큰을 헤더로 추가
        urlRequest.setValue(accessToken, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(refreshToken, forHTTPHeaderField: "Refresh")
        print("adator new headers 적용: \(urlRequest.headers)")
        
        // 전처리한 url이 서버로 보내짐, 수정된 요청으로 완료
        completion(.success(urlRequest))
    }
    
    let retryLimit = 3 // 재시도 횟수
    let retryDelay: TimeInterval = 1 // 재시도 간격
    
    //  오류 발생 시 API 요청을 재시도하는 역할
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print(#function, "retry 진입")
        
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 419 else {
            print("guard - doNotRetryWithError")
            completion(.doNotRetryWithError(error))
            return
        }
        
        //과호출 이슈 - 이전 코드
//        JoinAPIManager.shared.refresh()
//        print("AcessToken 갱신 함수 실행")
//        completion(.retry)
        
        // AcessToken 갱신 API 호출
        JoinAPIManager.shared.refresh { isSuccess in
            if isSuccess {
                if request.retryCount < self.retryLimit {
                    print("AcessToken 갱신 성공: 토큰 재발급 성공")
                    completion(.retryWithDelay(TimeInterval(self.retryLimit)))
                }
            } else {
                print("AcessToken 갱신 실패: 로그인 화면으로 전환")
                UserLoginManager.shared.isLogin = false
                NotificationCenter.default.post(name: .accessTokenRefreshFailed, object: nil)
                completion(.doNotRetryWithError(error))
            }
        }
        print("AccessToken 갱신 API: refresh 함수 호출")
    }
    
}


//MARK: - 무한루프 adapt-retry...과호출

// refresh 메서드가 Single<Result<RefreshOutput, APIError>>
// 계속 성공으로 리턴되는 Single 타입이라서?

//  JoinAPIManager.swift

//    func refresh() -> Single<Result<RefreshOutput, APIError>> {
//        return request(target: .refresh, model: RefreshOutput.self)
//    }


//  AuthInterceptor.swift

//JoinAPIManager.shared.refresh()
//    .observe(on: MainScheduler.instance)
//    .subscribe(with: self) { owner, result in
//        switch result {
//        case .success(let data):
//            // 성공: 토큰 재발급 성공 -> 이전에 실패했던 통신을 새 토큰으로 다시 시도
//            print("AcessToken 갱신 성공: ", data)
//            completion(.retry)
//        case .failure(let error):
//            // 실패: 갱신 실패 -> 로그인 화면으로 전환
//            print("AcessToken 갱신 실패: ", error)
//            // Notification post 화면 전환
//            completion(.doNotRetryWithError(error))
//        }
//    }
//    .disposed(by: disposeBag)
