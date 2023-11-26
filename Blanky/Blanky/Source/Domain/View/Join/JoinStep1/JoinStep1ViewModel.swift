//
//  JoinStep1ViewModel.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/19.
//

import Foundation
import RxSwift
import RxCocoa

class JoinStep1ViewModel: BaseViewModel {
    
    struct Input {
        let emailTextField: ControlProperty<String>
        let checkEmailDuplicationButton: ControlEvent<Void> //이메일 중복 확인 버튼
        let passwordTextField: ControlProperty<String>
        let checkPasswordTextField: ControlProperty<String>
        let nextButton: ControlEvent<Void>
    }
    
    struct Output {
        let emailValidation: Driver<Bool> //이메일 유효성 검사
        let checkEmailDuplicationResult: Driver<(String, String, Bool)> //네트워크 통신해서 이메일 중복 확인
        let passwordValidation: Driver<Bool> //비밀번호 유효성 검사
        let checkPasswordValidation: Driver<Bool> //비밀번호 확인
        let finalValidation: Driver<Bool> //모든 유효성 검사 완료했는지 최종 확인
        let nextButtonTap: Driver<(Bool, JoinInput)> //다음 버튼 탭
    }
    
    var finalUserInfo = BehaviorRelay<JoinInput>(value: JoinInput(email: "", password: "", nick: ""))
    
    let disposeBag = DisposeBag()
    
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
        
        //이메일 중복 확인 버튼
        let checkEmailDuplicationResult = input.checkEmailDuplicationButton
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.emailTextField)
            .flatMap { email in
                PostAPIManager.shared.validateEmail(email: email)
                    .map { result in
                        switch result {
                        case .success(let data):
                            self.finalUserInfo.accept(JoinInput(email: email, password: self.finalUserInfo.value.password, nick: ""))
                            return (email, data.message, true)
                        case .failure(let error):
                            return (email, error.errorDescription, false)
                        }
                    }
            }
            .debug()
            .asDriver(onErrorJustReturn: ("", "", false))
        
        //비밀번호 유효성 검사
        let passwordValidation = input.passwordTextField
            .debounce(.milliseconds(400), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map { text in
                let passwordRegex = "^[A-Za-z0-9!_@$%^&+=]{8,20}$"
                guard let _ = text.range(of: passwordRegex, options: .regularExpression) else {
                    return false
                }
                return true
            }
            .asDriver(onErrorJustReturn: false)
        
        //비밀번호 확인 유효성 검사
        let checkPasswordValidation = Observable.combineLatest(input.checkPasswordTextField.asObservable(), input.passwordTextField.asObservable())
            .debounce(.milliseconds(400), scheduler: MainScheduler.instance)
            .map { checkPassword, password in
                guard !checkPassword.isEmpty else {
                    return false
                }
                self.finalUserInfo.accept(JoinInput(email: self.finalUserInfo.value.email, password: checkPassword, nick: ""))
                return checkPassword == password
            }
            .asDriver(onErrorJustReturn: false)
        
        //모든 유효성 검사 완료했는지 최종 확인
        let finalValidation = Driver.combineLatest(
            checkEmailDuplicationResult.map { $0.2 },
            checkPasswordValidation
        ).map { emailCheck, passwordCheck in
            return emailCheck && passwordCheck
        }.asDriver(onErrorJustReturn: false)
        
        //다음 버튼 탭
        let nextButtonTap = input.nextButton
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(Observable.combineLatest(input.emailTextField, input.passwordTextField, self.finalUserInfo.asObservable()))
            .map { email, password, useInfo in
                if email == self.finalUserInfo.value.email && password == self.finalUserInfo.value.password {
                    return (true, useInfo)
                } else {
                    return (false, useInfo)
                }
            }
            .asDriver(onErrorJustReturn: (false, JoinInput(email: "", password: "", nick: "")))
        
        return Output(
            emailValidation: emailValidation,
            checkEmailDuplicationResult: checkEmailDuplicationResult, 
            passwordValidation: passwordValidation,
            checkPasswordValidation: checkPasswordValidation,
            finalValidation: finalValidation, 
            nextButtonTap: nextButtonTap
        )
    }
    
}
