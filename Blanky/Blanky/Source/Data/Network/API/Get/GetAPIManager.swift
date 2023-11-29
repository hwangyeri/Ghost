//
//  GetAPIManager.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/28.
//

import Foundation
import Moya
import RxSwift

final class GetAPIManager {
    
    static let shared = GetAPIManager()
    
    private let provider = MoyaProvider<GetAPI>()
    
    private let disposeBag = DisposeBag()
    
    private init() { }
    
    func request<T: Decodable, U: TargetType>(target: U, model: T.Type) -> Single<Result<T, APIError>> {
        return Single<Result<T, APIError>>.create { single in
            if let target = target as? GetAPI {
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
            } else {
                single(.success(.failure(.unknownError)))
            }
            
            return Disposables.create()
        }
    }

    // MARK: AcessToken 갱신
    func refresh() -> Single<Result<RefreshOutput, APIError>> {
        return request(target: GetAPI.refresh, model: RefreshOutput.self)
    }

    // MARK: 회원 탈퇴
    func withdraw() -> Single<Result<WithdrawOutput, APIError>> {
        return request(target: GetAPI.withdraw, model: WithdrawOutput.self)
    }
    
}
