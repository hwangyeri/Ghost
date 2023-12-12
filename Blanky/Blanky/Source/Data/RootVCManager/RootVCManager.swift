//
//  RootVCManager.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/12.
//

import UIKit

final class RootVCManager {
    
    static let shared = RootVCManager()
    
    private init() {}
    
    func changeRootVC(_ vc: UIViewController) {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.changeRootVC(vc, animated: true)
        } else {
            print("changeRootVC Error")
        }
    }
    
}
