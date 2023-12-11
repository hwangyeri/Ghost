//
//  JoinStep2ViewModel.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/26.
//

import Foundation
import RxSwift
import RxCocoa

class JoinStep2ViewModel: BaseViewModel {
    
    struct Input {
        let useInfo: JoinInput
        let nicknameTextField: ControlProperty<String>
        let randomButton: ControlEvent<Void>
        let doneButton: ControlEvent<Void>
    }
    
    struct Output {
        let nicknameValidation: Driver<Bool> //닉네임 유효성 검사
        let randomButtonTap: Driver<String> //랜덤 닉네임 생성 버튼
        let doneButtonTap: Driver<Bool> //가입 완료 버튼
    }
    
    func transform(input: Input) -> Output {
        
        let userInfoBehavior = BehaviorRelay<JoinInput>(value: JoinInput(email: input.useInfo.email, password: input.useInfo.password, nick: ""))
        
        //닉네임 유효성 검사
        let nicknameValidation = input.nicknameTextField
            .debounce(.milliseconds(400), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map { text in
                let nicknameRegex = "^[0-9가-힣]{2,10}$"
                guard let _ = text.range(of: nicknameRegex, options: .regularExpression) else {
                    return false
                }
                userInfoBehavior.accept(JoinInput(email: userInfoBehavior.value.email, password: userInfoBehavior.value.password, nick: text))
                print(userInfoBehavior)
                return true
            }
            .asDriver(onErrorJustReturn: false)
        
        //랜덤 닉네임 생성 버튼
        let randomButtonTap = input.randomButton
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .map { _ in
                return NicknameDataManager.shared.createRandomNickname()
            }
            .asDriver(onErrorJustReturn: "")
        
        //가입 완료 버튼
        let doneButtonTap = input.doneButton
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(Observable.combineLatest(nicknameValidation.asObservable(), userInfoBehavior))
            .flatMap { isValid, userInfo in
                guard isValid else {
                    return Observable.just(false)
                }
                
                return JoinAPIManager.shared.join(email: userInfo.email, password: userInfo.password, nick: userInfo.nick)
                    .map { result in
                        switch result {
                        case .success(let data):
                            print("회원가입 성공: ", data)
                            return true
                        case .failure(let error):
                            print("회원가입 실패: ", error.errorDescription)
                            return false
                        }
                    }
                    .asObservable()
            }
            .asDriver(onErrorJustReturn: false)
        
        
        return Output(
            nicknameValidation: nicknameValidation,
            randomButtonTap: randomButtonTap,
            doneButtonTap: doneButtonTap
        )
    }
    
    
}
