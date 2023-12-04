//
//  PostViewModel.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/04.
//

import Foundation
import RxSwift
import RxCocoa

class PostViewModel: BaseViewModel {
    
    struct Input {
        let postButton: ControlEvent<Void> //게시글 등록 버튼
        let titleTextField: ControlProperty<String>
        let contentTextView: ControlProperty<String>
    }
    
    struct Output {
        let textFieldValidation: Driver<Bool> //제목, 내용 텍스트필드 둘다 빈값이 아닌지 확인
        let postButtonTap: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        
        let titleEmpty = input.titleTextField
            .map { !$0.isEmpty }
        
        let contentEmpty = input.contentTextView
            .map { !$0.isEmpty }
        
        //제목, 내용 텍스트필드 둘다 입력했는지 확인
        let textFieldValidation = Observable.combineLatest(titleEmpty, contentEmpty)
            .map { $0 && $1 }
            .asDriver(onErrorJustReturn: false)
        
        //게시글 등록 버튼 탭
        let postButtonTap = input.postButton
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .asDriver(onErrorJustReturn: ())
        
        
        return Output(
            textFieldValidation: textFieldValidation,
            postButtonTap: postButtonTap
        )
    }
    
}
