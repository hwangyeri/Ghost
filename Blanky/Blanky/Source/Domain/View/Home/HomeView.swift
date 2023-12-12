//
//  HomeView.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/30.
//

import UIKit
import SnapKit
import Then

final class HomeView: BaseView {
    
    let mainLabel = UILabel().then {
        $0.text = "NEW"
        $0.font = .dangamFont(size: 20)
        $0.textColor = .point
    }
    
    let subLabel = UILabel().then {
        $0.text = "피드"
        $0.font = .dangamFont(size: 20)
    }

    let profileButton = UIButton().then {
        $0.backgroundColor = .bColor200
        $0.layer.cornerRadius = 20
    }
    
    let profileImageView1 = UIImageView().then {
        $0.image = UIImage(named: "ghost")
        $0.layer.cornerRadius = 18
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
    }
    
    let profileImageView2 = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.forward")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .white
    }
    
    let searchButton = GImageButton(
        imageSize: 18,
        imageName: "magnifyingglass",
        backgroundColor: .bColor200,
        tintColor: .white,
        cornerRadius: 15
    )
    
    let backView = GBackView()
    
    lazy var tableView = UITableView().then {
        $0.rowHeight = UITableView.automaticDimension
        $0.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        $0.estimatedRowHeight = 100
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
        
        [profileImageView1, profileImageView2].forEach {
            profileButton.addSubview($0)
        }
    }
    
    override func configureLayout() {
        searchButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(55)
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(40)
        }
        
        profileButton.snp.makeConstraints { make in
            make.top.equalTo(searchButton)
            make.trailing.equalTo(searchButton.snp.leading).offset(-13)
            make.width.equalTo(60)
            make.height.equalTo(40)
        }
        
        profileImageView1.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(3)
            make.size.equalTo(35)
        }
        
        profileImageView2.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(5)
            make.size.equalTo(16)
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
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        plusButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.size.equalTo(50)
        }
    }
    
    
}
