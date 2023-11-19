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
        let passwordTextField: ControlProperty<String>
        let checkPasswordTextField: ControlProperty<String>
        let checkDuplicationButton: ControlEvent<Void>
        let nextButton: ControlEvent<Void>
    }
    
    struct Output {
        let emailValidation: Driver<Bool> // 이메일 유효성 검사
        let passwordValidation: Driver<Bool> // 비밀번호 유효성 검사
        let checkPasswordValidation: Driver<Bool> // 비밀번호 확인
        let checkDuplication: Driver<Bool> // 이메일 중복 확인
        let finalValidation: Driver<Bool> // 모든 유효성 검사 완료했는지 최종 확인
    }
    
//    let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let emailValidation = input.emailTextField
            .map { text in
                let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
                guard let _ = text.range(of: emailRegex, options: .regularExpression) else {
                    return false
                }
                return true
            }
            .asDriver(onErrorJustReturn: false)
        
        let passwordValidation = input.passwordTextField
            .map { text in
                let passwordRegex = "^[A-Za-z0-9!_@$%^&+=]{8,20}$"
                guard let _ = text.range(of: passwordRegex, options: .regularExpression) else {
                    return false
                }
                return true
            }
            .asDriver(onErrorJustReturn: false)
        
        let checkPasswordValidation = Observable
            .combineLatest(input.checkPasswordTextField.asObservable(), input.passwordTextField.asObservable())
            .map { checkPassword, password in
                checkPassword == password
            }
            .asDriver(onErrorJustReturn: false)
        
        
        return Output(
            emailValidation: emailValidation,
            passwordValidation: passwordValidation,
            checkPasswordValidation: checkPasswordValidation,
            // FIXME
            checkDuplication: emailValidation,
            finalValidation: emailValidation
        )
    }
    
}