//
//  GTextButton.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/18.
//

import UIKit

final class GTextButton: UIButton {
    
    init(text: String) {
        super.init(frame: .zero)
        
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = .customFont(.medium, size: .S)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


