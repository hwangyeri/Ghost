//
//  Alert+.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/24.
//

import UIKit

extension UIViewController {
    
    func showAlertMessage(title: String, message: String, handler: (() -> ())? = nil ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            handler?()
        }
        
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
