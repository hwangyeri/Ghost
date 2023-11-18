//
//  BButton.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/18.
//

import UIKit

final class BButton: UIButton {
    
    init(text: String, titleColor: UIColor, cornerRadius: CGFloat, backgroundColor: UIColor) {
        super.init(frame: .zero)
        
        self.setTitle(text, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.layer.cornerRadius = cornerRadius
        self.titleLabel?.font = .customFont(.semiBold, size: .M)
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

