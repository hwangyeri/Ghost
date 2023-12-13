//
//  HomeViewModel.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/30.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeViewModel: BaseViewModel {
    
    struct Input {
        let plusButton: ControlEvent<Void>
        let profileButton: ControlEvent<Void>
    }
    
    struct Output {
        let plusButtonTap: Driver<Void> //게시글 작성 버튼 탭
        let profileButtonTap: Driver<Void> //프로필 버튼 탭
    }
    
    func transform(input: Input) -> Output {
        
        //게시글 작성 버튼 탭
        let plusButtonTap = input.plusButton
            .do(onNext: { _ in
                print("plusButtonTap")
            })
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .asDriver(onErrorJustReturn: ())
        
        let profileButtonTap = input.profileButton
            .do(onNext: { _ in
                print("profileButtonTap")
            })
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .asDriver(onErrorJustReturn: ())
        
        
        return Output(
            plusButtonTap: plusButtonTap,
            profileButtonTap: profileButtonTap
        )
    }
    
}
