//
//  SettingView.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/21.
//

import UIKit
import SnapKit
import Then

final class SettingView: BaseView {
    
    let tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.estimatedRowHeight = 100
        $0.rowHeight = UITableView.automaticDimension
        $0.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        $0.backgroundColor = .bColor100
    }
    
    override func configureHierarchy() {
        self.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
}
