//
//  HomeView.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/30.
//

import UIKit
import SnapKit
import Then

class HomeView: BaseView {
    
    let mainLabel = UILabel().then {
        $0.text = "NEW"
        $0.font = .dangamFont(size: 20)
        $0.textColor = .point
    }
    
    let subLabel = UILabel().then {
        $0.text = "피드"
        $0.font = .dangamFont(size: 20)
    }

    let profileButton = GImageButton(
        imageSize: 17,
        imageName: "star",
        backgroundColor: .bColor300,
        tintColor: .white,
        cornerRadius: 15
    ).then {
        $0.setImage(UIImage(named: "ghost"), for: .normal)
    }
    
    let searchButton = GImageButton(
        imageSize: 18,
        imageName: "magnifyingglass",
        backgroundColor: .bColor300,
        tintColor: .white,
        cornerRadius: 15
    )
    
    let backView = UIView().then {
        $0.backgroundColor = UIColor.bColor200
        $0.layer.cornerRadius = 40
    }
    
    lazy var tableView = UITableView().then {
        $0.rowHeight = UITableView.automaticDimension
        $0.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        $0.estimatedRowHeight = UITableView.automaticDimension
        $0.backgroundColor = .bColor200
    }
    
    let plusButton = GImageButton(
        imageSize: 22,
        imageName: "plus",
        backgroundColor: .black,
        tintColor: .point,
        cornerRadius: 24
    ).then {
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.bColor100.cgColor
    }
    
    override func configureHierarchy() {
        [mainLabel, subLabel, profileButton, searchButton, backView, plusButton].forEach {
            self.addSubview($0)
        }
        
        backView.addSubview(tableView)
    }
    
    override func configureLayout() {
        
        searchButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(55)
            make.trailing.equalToSuperview().inset(17)
            make.size.equalTo(40)
        }
        
        profileButton.snp.makeConstraints { make in
            make.top.equalTo(searchButton)
            make.trailing.equalTo(searchButton.snp.leading).offset(-15)
            make.size.equalTo(40)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.centerY.equalTo(searchButton)
            make.leading.equalToSuperview().inset(15)
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel).offset(-1)
            make.leading.equalTo(mainLabel.snp.trailing).offset(5)
        }
        
        backView.snp.makeConstraints { make in
            make.top.equalTo(profileButton.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }
        
        plusButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.size.equalTo(50)
        }
    }
    
    
}
