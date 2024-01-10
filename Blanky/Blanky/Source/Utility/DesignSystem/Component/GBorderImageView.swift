//
//  GBorderImageView.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/10.
//

import UIKit

final class GBorderImageView: UIImageView {
    
    init(borderWidth: CGFloat, cornerRadius: CGFloat) {
        super.init(frame: .zero)
        
        self.image = UIImage(named: "ghost")
        self.layer.cornerRadius = cornerRadius
        self.contentMode = .scaleAspectFill
        self.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
