//
//  KeychainManager.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/27.
//

import Foundation
import SwiftKeychainWrapper

final class KeychainManager {
    
    static let shared = KeychainManager()
    
    private init() {}
    
    private struct KeychainKeys {
        static let userID: String = "User.UserID.Key"
        static let tokenKey: String = "User.Token.Key"
        static let refreshTokenKey: String = "User.RefreshToken.Key"
    }
    
    var userID: String? {
        get {
            KeychainWrapper.standard.string(forKey: KeychainKeys.userID)
        }
        set {
            if let value = newValue {
                KeychainWrapper.standard.set(value, forKey: KeychainKeys.userID)
            } else {
                KeychainWrapper.standard.removeObject(forKey: KeychainKeys.userID)
            }
        }
    }
    
    var token: String? {
        get {
            KeychainWrapper.standard.string(forKey: KeychainKeys.tokenKey) //Keychain 반환
        }
        set {
            if let value = newValue {
                KeychainWrapper.standard.set(value, forKey: KeychainKeys.tokenKey) //Keychain 저장
            } else {
                KeychainWrapper.standard.removeObject(forKey: KeychainKeys.tokenKey) //Keychain 삭제
            }
        }
    }
    
    var refreshToken: String? {
        get {
            KeychainWrapper.standard.string(forKey: KeychainKeys.refreshTokenKey)
        }
        set {
            if let value = newValue {
                KeychainWrapper.standard.set(value, forKey: KeychainKeys.refreshTokenKey)
            } else {
                KeychainWrapper.standard.removeObject(forKey: KeychainKeys.refreshTokenKey)
            }
        }
    }
    
    //모든 키 삭제
    func removeAllKeys() {
        KeychainWrapper.standard.removeAllKeys()
    }
    
}
