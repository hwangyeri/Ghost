//
//  LoginViewModel.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/27.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel: BaseViewModel {
    
    struct Input {
        let emailTextField: ControlProperty<String>
        let passwordTextField: ControlProperty<String>
        let loginButton: ControlEvent<Void>
        let findEmailButton: ControlEvent<Void>
        let findPasswordButton: ControlEvent<Void>
        let joinButton: ControlEvent<Void>
    }
    
    struct Output {
        let emailValidation: Driver<Bool> //이메일 유효성 검사
        let passwordValidation: Driver<Bool> //비밀번호 유효성 검사
        let finalValidation: Driver<Bool> //모든 유효성 검사 완료했는지 최종 확인
        let loginButtonTap: Driver<(Bool, String)> //로그인 버튼 탭
        let findEmailButtonTap: ControlEvent<Void> //이메일 찾기 버튼 탭
        let findPasswordButtonTap: ControlEvent<Void> //비밀번호 찾기 버튼 탭
        let joinButtonTap: Driver<Void> //회원가입 버튼 탭
    }
    
    func transform(input: Input) -> Output {
        
        //이메일 유효성 검사
        let emailValidation = input.emailTextField
            .debounce(.milliseconds(400), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map { text in
                let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
                guard let _ = text.range(of: emailRegex, options: .regularExpression) else {
                    return false
                }
                return true
            }
            .asDriver(onErrorJustReturn: false)
        
        //비밀번호 유효성 검사
        let passwordValidation = input.passwordTextField
            .debounce(.milliseconds(400), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map { text in
                let passwordRegex = "^(?=.*[!_@$%^&+=])[A-Za-z0-9!_@$%^&+=]{8,20}$"
                guard let _ = text.range(of: passwordRegex, options: .regularExpression) else {
                    return false
                }
                return true
            }
            .asDriver(onErrorJustReturn: false)
        
        //모든 유효성 검사 완료했는지 최종 확인
        let finalValidation = Driver.combineLatest(emailValidation, passwordValidation)
            .map { emailCheck, passwordCheck in
                return emailCheck && passwordCheck
            }
            .asDriver(onErrorJustReturn: false)
         
        //로그인 버튼 탭
        let loginButtonTap = input.loginButton
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(Observable.combineLatest(input.emailTextField, input.passwordTextField))
            .flatMap { email, password in
                JoinAPIManager.shared.login(email: email, password: password)
                    .map { result in
                        switch result {
                        case .success(let data):
                            print("로그인 성공")
                            UserLoginManager.shared.isLogin = true
                            //키체인에 토큰 및 유저ID 저장
                            KeychainManager.shared.userID = data._id
                            KeychainManager.shared.token = data.token
                            KeychainManager.shared.refreshToken = data.refreshToken
                            return (true, "")
                        case .failure(let error):
                            print("로그인 실패")
                            UserLoginManager.shared.isLogin = false
                            return (false, error.errorDescription)
                        }
                    }
            }
            .asDriver(onErrorJustReturn: (false, ""))
        
        //FIXME: 이메일 찾기 버튼 탭
        //FIXME: 비밀번호 찾기 버튼 탭
        
        //회원가입 버튼 탭
        let joinButtonTap = input.joinButton
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .asDriver(onErrorJustReturn: ())
        
        
        return Output(
            emailValidation: emailValidation,
            passwordValidation: passwordValidation, 
            finalValidation: finalValidation,
            loginButtonTap: loginButtonTap,
            findEmailButtonTap: input.findEmailButton,
            findPasswordButtonTap: input.findPasswordButton,
            joinButtonTap: joinButtonTap
        )
    }
    
    
}
