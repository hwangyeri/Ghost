//
//  PostViewModel.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/04.
//

import Foundation
import RxSwift
import RxCocoa

final class PostViewModel: BaseViewModel {
    
    struct Input {
        let xButton: ControlEvent<Void> //작성 종료 버튼
        let postButton: ControlEvent<Void> //게시글 등록 버튼
        let titleTextField: ControlProperty<String> //제목 텍스트필드
        let contentTextView: ControlProperty<String> //내용 텍스트필드
        let imageRelay: PublishRelay<[Data]> //추가한 이미지 배열
    }
    
    struct Output {
        let xButtonTap: Driver<Void>
        let postButtonTap: Driver<Bool> //게시글 등록하기 버튼
        let textFieldValidation: Driver<Bool> // 제목, 내용 텍스트필드 둘다 빈값이 아닌지 확인
    }
    
    func transform(input: Input) -> Output {
        
        //작성 종료 버튼 탭
        let xButtonTap = input.xButton
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .asDriver(onErrorJustReturn: ())
        
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
            .withLatestFrom(Observable.combineLatest(input.titleTextField, input.contentTextView, input.imageRelay))
            .flatMap { title, content, image in
                print("---", title, content, image)
                return PostAPIManager.shared.postCreate(title: title, content: content, file: image)
                    .map { result in
                        switch result {
                        case .success(let data):
                            print("포스트 작성 성공: ", data)
                            return true
                        case .failure(let error):
                            print("포스트 작성 실패: ", error)
                            return false
                        }
                    }
            }
            .asDriver(onErrorJustReturn: false)
        
        
        return Output(
            xButtonTap: xButtonTap, 
            postButtonTap: postButtonTap,
            textFieldValidation: textFieldValidation
        )
    }
    
}
