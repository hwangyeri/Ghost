//
//  GBackView.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/11.
//

import UIKit

final class GBackView: UIView {
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .bColor200
        self.layer.cornerRadius = 35
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

