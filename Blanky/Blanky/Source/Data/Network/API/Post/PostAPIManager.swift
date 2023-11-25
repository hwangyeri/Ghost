//
//  PostAPIManager.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/22.
//

import Foundation
import Moya
import RxSwift
//import RxMoya

final class PostAPIManager {
    
    static let shared = PostAPIManager()
    
    private let provider = MoyaProvider<PostAPI>() // Moya의 TargetType을 따르는 enum
    
    private let disposeBag = DisposeBag()
    
    private init() { }
    
       // MARK: - 회원 가입
//       func join(email: String, password: String, nick: String) -> Single<Result<JoinInput, Error>> {
//           let input = JoinInput(email: email, password: password, nick: nick)
//           
//           provider.rx.request(.join(model: input)).subscribe { result in
//               switch result {
//               case .success(let response):
//                   print(response)
//               case .failure(let error):
//                   print(error)
//               }
//           }
//       }
       
       // MARK: - 이메일 중복 확인
    func validateEmail(email: String) -> Single<Result<ValidationEmailOutput, APIError>> {
        let input = ValidationEmailInput(email: email)
        
        return Single<Result<ValidationEmailOutput, APIError>>.create { single in
            self.provider.request(.validationEmail(model: input)) { result in
                
                print(result)
                
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode(ValidationEmailOutput.self, from: response.data)
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
       
       // MARK: - 로그인
//       func login(email: String, password: String) -> Single<Result<LoginInput, APIError>> {
//           let input = LoginInput(email: email, password: password)
//           
//           provider.rx.request(.login(model: input)).subscribe { result in
//               switch result {
//               case .success(let response):
//                   print(response)
//               case .failure(let error):
//                   print(error)
//               }
//           }
//       }
    
}
