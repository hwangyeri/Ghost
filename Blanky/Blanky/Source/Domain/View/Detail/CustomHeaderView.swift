//
//  CustomHeaderView.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/16.
//

import UIKit
import SnapKit
import Then

final class CustomHeaderView: UIView {
    
    let titleLabel = UILabel().then {
        $0.text = "댓글"
        $0.font = .customFont(.regular, size: .XS)
        $0.textColor = .lightGray
    }
    
    let divider = GDivider()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        [titleLabel, divider].forEach {
            self.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
            make.height.equalTo(0.5)
        }
    }
    
}
