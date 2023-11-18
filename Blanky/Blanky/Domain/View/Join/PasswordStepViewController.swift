//
//  PasswordStepViewController.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/18.
//

import UIKit

class PasswordStepViewController: BaseViewController {
    
    private let mainView = PasswordStepView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
