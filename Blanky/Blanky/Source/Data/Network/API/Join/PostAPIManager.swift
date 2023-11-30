//
//  PostAPIManager.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/22.
//

import Foundation
import Moya
import RxSwift

final class PostAPIManager {
    
    static let shared = PostAPIManager()
    
    private let provider = MoyaProvider<PostAPI>() // Moya의 TargetType을 따르는 enum
    
    private let disposeBag = DisposeBag()
    
    private init() { }
    
    func request<T: Decodable>(target: PostAPI, model: T.Type) -> Single<Result<T, APIError>> {
        return Single<Result<T, APIError>>.create { single in
            self.provider.request(target) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: response.data)
                        single(.success(.success(decodedData)))
                    } catch {
                        single(.success(.failure(.decodedError)))
                    }
                case .failure(let error):
                    guard let customError = APIError(rawValue: error.response?.statusCode ?? 1) else {
                        single(.success(.failure(.unknownError)))
                        return
                    }
                    single(.success(.failure(customError)))
                }
            }
            return Disposables.create()
        }
    }
    
    //MARK: - 회원 가입
    func join(email: String, password: String, nick: String) -> Single<Result<JoinOutput, APIError>> {
        let input = JoinInput(email: email, password: password, nick: nick)
        return request(target: .join(model: input), model: JoinOutput.self)
    }
    
    //MARK: - 이메일 중복 확인
    func validateEmail(email: String) -> Single<Result<ValidationEmailOutput, APIError>> {
        let input = ValidationEmailInput(email: email)
        return request(target: .validationEmail(model: input), model: ValidationEmailOutput.self)
    }
    
    //MARK: - 로그인
    func login(email: String, password: String) -> Single<Result<LoginOutput, APIError>> {
        let input = LoginInput(email: email, password: password)
        return request(target: .login(model: input), model: LoginOutput.self)
    }
    
    // MARK: AcessToken 갱신
    func refresh() -> Single<Result<RefreshOutput, APIError>> {
        return request(target: .refresh, model: RefreshOutput.self)
    }
    
    // MARK: 회원 탈퇴
    func withdraw() -> Single<Result<WithdrawOutput, APIError>> {
        return request(target: .withdraw, model: WithdrawOutput.self)
    }
    
}
