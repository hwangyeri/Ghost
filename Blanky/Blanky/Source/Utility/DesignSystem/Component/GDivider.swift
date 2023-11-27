//
//  GDivider.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/18.
//

import UIKit

final class GDivider: UIView {
    
    init() {
        super.init(frame: .zero)
       
        self.backgroundColor = .darkGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
