//
//  FirstSwipeView.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/20.
//

import UIKit
import SnapKit
import Then

final class FirstSwipeView: BaseView {
    
    let loadingIndicator = UIActivityIndicatorView(style: .large).then {
        $0.hidesWhenStopped = true
    }
    
    let tableView = UITableView(frame: .zero, style: .plain).then {
        $0.estimatedRowHeight = 100
        $0.rowHeight = UITableView.automaticDimension
        $0.register(FirstSwipeTableViewCell.self, forCellReuseIdentifier: FirstSwipeTableViewCell.identifier)
        $0.backgroundColor = .bColor200
    }
    
    override func configureHierarchy() {
        [loadingIndicator, tableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
