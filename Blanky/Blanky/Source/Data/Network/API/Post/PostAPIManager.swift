//
//  PostAPIManager.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/22.
//

import Foundation
import Moya
import RxSwift
import RxMoya

final class PostAPIManager {
    
    static let shared = PostAPIManager()
    
    private let provider = MoyaProvider<PostAPI>()
    
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
//       func validateEmail(email: String) -> Single<Result<ValidationEmailInput, Error>> {
//           let input = ValidationEmailInput(email: email)
//           
//           return Single.create { single in
//               self.provider.rx.request(.validationEmail(model: input)).subscribe { result in
//                   switch result {
//                   case .success(let response):
//                      print(response)
//                   case .failure(let error):
//                      print(error)
//                   }
//               }
//           }
//       }
    
    func validateEmail(email: String) -> Single<Result<ValidationEmailInput, APIError>> {
        let input = ValidationEmailInput(email: email)
        
        return Single.create { single in
            self.provider.rx.request(.validationEmail(model: input)).subscribe { result in
                switch result {
                case .success(let response):
                   print(response)
                case .failure(let error):
                   print(error)
                }
            }
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
