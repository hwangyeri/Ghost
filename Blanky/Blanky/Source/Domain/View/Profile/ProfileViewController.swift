//
//  ProfileViewController.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/13.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    private let mainView = ProfileView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}
