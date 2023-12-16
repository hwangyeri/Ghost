//
//  DetailView.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/14.
//

import UIKit
import SnapKit
import Then

final class DetailView: BaseView {
    
    let loadingIndicator = UIActivityIndicatorView(style: .large).then {
        $0.hidesWhenStopped = true
    }
    
    let tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        $0.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier)
        $0.separatorStyle = .none
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 100
        $0.backgroundColor = .bColor200
        $0.layer.cornerRadius = 35
      }
    
    let commentsView = UIView().then {
        $0.backgroundColor = .bColor200
    }
    
    let borderView = UIView().then {
        $0.backgroundColor = .bColor200
        $0.layer.cornerRadius = 28
        $0.layer.borderColor = UIColor.bColor300.cgColor
        $0.layer.borderWidth = 1.5
    }
    
    let contentTextField = GTextField(
        weight: .regular, size: .S,
        returnKeyType: .done
    ).then {
        $0.placeholder = "댓글 달기"
        $0.backgroundColor = .bColor200
    }
    
    let writeButton = GImageButton(
        imageSize: 20,
        imageName: Constant.pencil,
        backgroundColor: .bColor200,
        tintColor: .white,
        cornerRadius: 0
    )
    
    let topScrollButton = GImageButton(
        imageSize: 16,
        imageName: "arrow.up",
        backgroundColor: .bColor100,
        tintColor: .white,
        cornerRadius: 20
    )
    
    override func configureHierarchy() {
        [loadingIndicator, tableView, commentsView].forEach {
            self.addSubview($0)
        }
        
        [borderView, topScrollButton].forEach {
            commentsView.addSubview($0)
        }
        
        [contentTextField, writeButton].forEach {
            borderView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(commentsView.snp.top).offset(30)
            make.horizontalEdges.equalToSuperview()
        }
        
        commentsView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(90)
        }
        
        borderView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(15)
            make.height.equalTo(55)
        }
        
        contentTextField.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
        
        writeButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(contentTextField.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(15)
            make.width.equalTo(30)
        }
        
        topScrollButton.snp.makeConstraints { make in
            make.centerY.equalTo(writeButton)
            make.leading.equalTo(borderView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(15)
            make.size.equalTo(40)
        }
    }
    
}
