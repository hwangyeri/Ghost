//
//  RankingViewController.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/23.
//

import UIKit
import RxSwift
import RxCocoa

final class RankingViewController: BaseViewController {
    
    private let mainView = RankingView()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}
