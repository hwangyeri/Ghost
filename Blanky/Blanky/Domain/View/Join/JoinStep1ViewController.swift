//
//  JoinViewController.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/16.
//

import UIKit

class JoinStep1ViewController: BaseViewController {
    
    private let mainView = JoinStep1View()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "회원가입"
    }
    

}
