//
//  BImageButton.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/26.
//

import UIKit

final class BImageButton: UIButton {
    
    init(imageSize: CGFloat, imageName: String, backgroundColor: UIColor, tintColor: UIColor, cornerRadius: CGFloat) {
        super.init(frame: .zero)
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: imageSize, weight: .regular)
        let image = UIImage(systemName: imageName, withConfiguration: imageConfig)
        
        self.setImage(image, for: .normal)
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        self.layer.cornerRadius = cornerRadius
        self.contentMode = .scaleAspectFit
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

