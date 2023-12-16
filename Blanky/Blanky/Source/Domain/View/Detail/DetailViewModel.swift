//
//  DetailViewModel.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/15.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailViewModel: BaseViewModel {
    
    struct Input {
        let postID: String
        let contentTextField: ControlProperty<String> // 댓글 텍스트필드
        let writeButton: ControlEvent<Void> // 댓글 작성 버튼
    }
    
    struct Output {
        let contentTextFieldValidation: Driver<Bool>
        let writeButtonTap: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        
        // 댓글 텍스트필드 빈 값 예외처리
        let contentTextFieldValidation = input.contentTextField
            .map { !$0.isEmpty }
            .asDriver(onErrorJustReturn: false)
        
        // 댓글 작성 버튼 탭
        let writeButtonTap = input.writeButton
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.contentTextField)
            .flatMap { text in
                print("댓글 작성 버튼 탭")
                return PostAPIManager.shared.commentCreate(id: input.postID, content: text)
                    .map { result in
                        switch result {
                        case .success(let data):
                            print("댓글 작성 성공: ", data)
                            return true
                        case .failure(let error):
                            print("댓글 작성 실패: ", error.errorDescription)
                            return false
                        }
                    }
            }
            .asDriver(onErrorJustReturn: false)
        
        
        return Output(
            contentTextFieldValidation: contentTextFieldValidation, 
            writeButtonTap: writeButtonTap
        )
    }
    
}
