//
//  BLabel.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/18.
//

import UIKit

final class BLabel: UILabel {
    
    init(text: String, fontWeight: UIFont.CustomFontWeight, fontSize: UIFont.CustomFontSize) {
        super.init(frame: .zero)
       
        self.text = text
        self.font = .customFont(fontWeight, size: fontSize)
        self.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
