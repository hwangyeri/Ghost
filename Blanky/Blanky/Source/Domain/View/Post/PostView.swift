//
//  PostView.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/03.
//

import UIKit
import SnapKit
import Then

final class PostView: BaseView {
    
    let xButton = GImageButton(
        imageSize: 16,
        imageName: "xmark",
        backgroundColor: .bColor200,
        tintColor: .white,
        cornerRadius: 15
    )
    
    let postButton = GButton(
        text: "등록",
        cornerRadius: 16,
        weight: .medium, size: .XS
    )
    
    let titleTextField = GTextField(
        weight: .medium, size: .M,
        returnKeyType: .next
    ).then {
        $0.placeholder = "제목을 입력해 주세요."
    }
    
    let divider = GDivider()
    
    let contentTextView = UITextView().then {
        $0.backgroundColor = .bColor100
        $0.font = .customFont(.regular, size: .S)
        $0.tintColor = .point
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
    }
    
    let contentTextViewToolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        
        let cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: nil, action: nil)
        let albumButton = UIBarButtonItem(image: UIImage(systemName: "photo"), style: .plain, target: nil, action: nil)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let dismissButton = UIBarButtonItem(image: UIImage(systemName: "keyboard.chevron.compact.down"), style: .plain, target: nil, action: nil)
        
        toolbar.items = [cameraButton, albumButton, flexibleSpace, dismissButton]
        toolbar.tintColor = .white
        
        return toolbar
    }()
    
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
        $0.showsHorizontalScrollIndicator = false
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 105, height: 105)
        return layout
    }
    
    override func configureHierarchy() {
        [xButton, postButton, titleTextField, divider, addImageButton, contentTextView, collectionView].forEach {
            self.addSubview($0)
        }
        
//        contentTextView.inputAccessoryView = contentTextViewToolbar
    }
    
    override func configureLayout() {
        xButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(-10)
            make.leading.equalToSuperview().inset(20)
            make.size.equalTo(42)
        }
        
        postButton.snp.makeConstraints { make in
            make.top.equalTo(xButton)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(32)
            make.width.equalTo(60)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(postButton.snp.bottom).offset(25)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom)
            make.horizontalEdges.equalTo(titleTextField)
            make.height.equalTo(1)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(titleTextField)
        }
        
        addImageButton.snp.makeConstraints { make in
            make.top.equalTo(contentTextView.snp.bottom).offset(25)
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(30)
            make.size.equalTo(90)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.equalTo(addImageButton.snp.trailing)
            make.trailing.equalToSuperview()
            make.verticalEdges.equalTo(addImageButton)
        }
    }
    
}
