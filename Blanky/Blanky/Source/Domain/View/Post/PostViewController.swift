//
//  PostViewController.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/03.
//

import UIKit
import RxSwift
import RxCocoa

class PostViewController: BaseViewController {
    
    private let mainView = PostView()
    
    private let viewModel = PostViewModel()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
    }
    
    override func configureLayout() {
        setCustomXButton()
    }
    
    private func bind() {
        
        let input = PostViewModel.Input(
            postButton: mainView.postButton.rx.tap,
            titleTextField: mainView.titleTextField.rx.text.orEmpty,
            contentTextView: mainView.contentTextView.rx.text.orEmpty)
        
        let output = viewModel.transform(input: input)
        
        output.textFieldValidation
            .drive(with: self) { owner, isValid in
                owner.mainView.postButton.backgroundColor = isValid ? .white : .gray
                owner.mainView.postButton.isEnabled = isValid
            }
            .disposed(by: disposeBag)
        
    }
   
    
}
