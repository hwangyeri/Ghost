//
//  PostView.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/03.
//

import UIKit
import SnapKit
import Then

class PostView: BaseView {
    
    //FIXME: 임시저장 버튼 추가하기
    
    let postButton = GButton(text: "등록").then {
        $0.layer.cornerRadius = 16
        $0.titleLabel?.font = .customFont(.medium, size: .XS)
    }
    
    let titleTextField = UITextField().then {
        $0.font = .customFont(.medium, size: .M)
        $0.tintColor = .point
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.keyboardType = .default
        $0.returnKeyType = .next
        $0.placeholder = "제목을 입력해 주세요."
    }
    
    let divider = GDivider()
    
    let contentTextView = UITextView().then {
        $0.backgroundColor = .bColor100
        $0.font = .customFont(.regular, size: .S)
        $0.tintColor = .point
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.keyboardType = .default
        $0.returnKeyType = .done
    }
    
    let addImageButton = GImageButton(
        imageSize: 18,
        imageName: "camera",
        backgroundColor: .bColor100,
        tintColor: .white,
        cornerRadius: 20
    ).then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.bColor300.cgColor
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout()).then {
        $0.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
        $0.backgroundColor = .bColor100
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        let size = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: size / 3, height: size / 3)
        return layout
    }
    
    override func configureHierarchy() {
        [postButton, titleTextField, divider, addImageButton, contentTextView, collectionView].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        postButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(55)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(32)
            make.width.equalTo(60)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(postButton.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom)
            make.horizontalEdges.equalTo(titleTextField)
            make.height.equalTo(1)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(titleTextField)
            make.bottom.equalTo(addImageButton.snp.top)
        }
        
        addImageButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.size.equalTo(75)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.equalTo(addImageButton.snp.trailing)
            make.trailing.equalToSuperview()
            make.verticalEdges.equalTo(addImageButton)
        }
    }
    
}
