//
//  SettingTableViewCell.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/21.
//

import UIKit
import SnapKit

final class SettingTableViewCell: BaseTableViewCell {
    
    let titleLabel = GLabel(
        text: "프로필 수정하기",
        fontWeight: .regular,
        fontSize: .M
    )
    
    let chevronImageView = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = .white
        $0.contentMode = .scaleAspectFit
    }

    override func configureHierarchy() {
        [titleLabel, chevronImageView].forEach {
            contentView.addSubview($0)
        }
        
        contentView.backgroundColor = .bColor100
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(10)
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
            make.size.equalTo(18)
        }
    }

}
