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
    
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 35))
        toastLabel.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2)
        toastLabel.backgroundColor = UIColor.bColor100.withAlphaComponent(0.7)
        toastLabel.textColor = UIColor.white
        toastLabel.font = .customFont(.regular, size: .XS)
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 16
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 2.2, delay: 0.2, options: .curveLinear, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    
}
