//
//  PostViewController.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/03.
//

import UIKit
import RxSwift
import RxCocoa
import PhotosUI

/*
 FIXME:
 1. 이미지 4개까지만 추가할 수 있도록 예외처리 필요
 2. 키보드 높이에 맞춰서 이미지 추가 버튼, 컬렉션 뷰의 높이 유동적으로 바꿔주기
 3. 임시 저장 버튼 추가하기
 4. 텍스트뷰 글자수, 줄바꿈 제한 안먹힘
 */

class PostViewController: BaseViewController {
    
    private let mainView = PostView()
    
    private let viewModel = PostViewModel()
    
    let disposeBag = DisposeBag()
    
    var selectedImages: [UIImage] = [] {
        didSet {
            print(selectedImages)
            updateSnapshot()
        }
    }
    
    private var collectionViewDataSource: UICollectionViewDiffableDataSource<Int, UIImage>!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        configureDataSource()
    }
    
    override func configureLayout() {
        setCustomXButton()
        mainView.collectionView.delegate = self
        mainView.contentTextView.delegate = self
        mainView.addImageButton.addTarget(self, action: #selector(addImageButtonTap), for: .touchUpInside)
    }
    
    private func bind() {
        
        let input = PostViewModel.Input(
            postButton: mainView.postButton.rx.tap,
            titleTextField: mainView.titleTextField.rx.text.orEmpty,
            contentTextView: mainView.contentTextView.rx.text.orEmpty)
        
        let output = viewModel.transform(input: input)
        
        output.textFieldValidation
            .drive(with: self) { owner, isValid in
                owner.mainView.postButton.backgroundColor = isValid ? .white : .gray
                owner.mainView.postButton.isEnabled = isValid
            }
            .disposed(by: disposeBag)
        
    }
    
    /// ActionSheet
    @objc private func addImageButtonTap() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "카메라", style: .default) { [weak self] _ in
            guard let self = self else { return }
            
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            
            present(imagePicker, animated: true)
        }
        
        let albumAction = UIAlertAction(title: "앨범", style: .default) { [weak self] _ in
            guard let self = self else { return }
            
            var configuration = PHPickerConfiguration()
            configuration.selectionLimit = 4
            configuration.filter = .images
            
            let phPicker = PHPickerViewController(configuration: configuration)
            phPicker.delegate = self
            
            present(phPicker, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .destructive)
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(albumAction)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true)
    }
    
    /// CollectionView DataSource
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<PostCollectionViewCell, UIImage> {
            cell, indexPath, itemIdentifier in
            cell.imageView.image = itemIdentifier
        }
        
        collectionViewDataSource = UICollectionViewDiffableDataSource(collectionView: mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        updateSnapshot()
    }
    
    /// Snapshot
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, UIImage>()
        snapshot.appendSections([0])
        snapshot.appendItems(selectedImages)
        collectionViewDataSource.apply(snapshot)
    }
    
}

//MARK: CollectionView 컬렉션뷰
extension PostViewController: UICollectionViewDelegate {
    
}

//MARK: ImagePicker 카메라
extension PostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            selectedImages.append(image)
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
}

//MARK: PHPicker 라이브러리
extension PostViewController: PHPickerViewControllerDelegate {
    
    //사진을 선택하고 난 후에 실행되는 메서드
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        for result in results {
            let itemProvider = result.itemProvider
            
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                    DispatchQueue.main.async {
                        if let selectedImage = image as? UIImage {
                            self?.selectedImages.append(selectedImage)
                        }
                    }
                }
            }
        }
    }
    
}

//MARK: TextView 텍스트뷰 - 게시글 내용
extension PostViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        
        // 글자수 제한
        let maxLength = 200
        if text.count > maxLength {
            textView.text = String(text.prefix(maxLength))
        }
        
        // 줄바꿈(들여쓰기) 제한
        let maxNumberOfLines = 10
        let lineBreakCharacter = "\n"
        let lines = text.components(separatedBy: lineBreakCharacter)
        var consecutiveLineBreakCount = 0 // 연속된 줄 바꿈 횟수
        
        for line in lines {
            if line.isEmpty { // 빈 줄이면 연속된 줄 바꿈으로 간주
                consecutiveLineBreakCount += 1
            } else {
                consecutiveLineBreakCount = 0
            }
            
            if consecutiveLineBreakCount > maxNumberOfLines {
                textView.text = String(text.dropLast()) // 마지막 입력 문자를 제거
                break
            }
        }
    }
    
}
