//
//  LogInViewController.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/16.
//

import UIKit

class LogInViewController: BaseViewController {
    
    private let mainView = LogInView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        view.backgroundColor = .brown
    }
    

}
