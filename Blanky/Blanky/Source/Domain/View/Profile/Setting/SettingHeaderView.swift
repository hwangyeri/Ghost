//
//  SettingHeaderView.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/21.
//

import UIKit
import SnapKit
import Then

final class SettingHeaderView: UIView {
    
    let titleLabel = UILabel().then {
        $0.text = "header"
        $0.font = .customFont(.regular, size: .XS)
        $0.textColor = .lightGray
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(15)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
    }
    
}

