//
//  UserLoginManager.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/11.
//

import Foundation

final class UserLoginManager {
    
    static let shared = UserLoginManager()
    
    private init() {}
    
    private enum Constants {
        static let isLoginKey = "isLogin"
    }
    
    var isLogin: Bool? {
        get {
            UserDefaults.standard.bool(forKey: Constants.isLoginKey)
        }
        set {
            if let value = newValue {
                UserDefaults.standard.setValue(value, forKey: Constants.isLoginKey)
            } else {
                UserDefaults.standard.removeObject(forKey: Constants.isLoginKey)
            }
        }
    }
    
}
