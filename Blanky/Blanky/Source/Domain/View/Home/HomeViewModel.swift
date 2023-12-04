//
//  HomeViewModel.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/30.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel {
    
    struct Input {
        let plusButton: ControlEvent<Void>
    }
    
    struct Output {
        let plusButtonTap: Driver<Void> //게시글 작성 버튼
    }
    
    func transform(input: Input) -> Output {
        
        //게시글 작성 버튼 탭
        let plusButtonTap = input.plusButton
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .asDriver(onErrorJustReturn: ())
        
        
        return Output(
            plusButtonTap: plusButtonTap
        )
    }
    
}
