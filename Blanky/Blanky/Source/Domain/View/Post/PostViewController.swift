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
 4. 텍스트뷰 글자수, 줄바꿈 제한
 5. 커스텀 버튼 -> 네비바 버튼으로 변경하기
 */

final class PostViewController: BaseViewController {
    
    private let mainView = PostView()
    
    private let viewModel = PostViewModel()
    
    let disposeBag = DisposeBag()
    
    private var selectedImages: [UIImage] = [] {
        didSet {
            updateSnapshot()
        }
    }
    
    private var imageRelay = PublishRelay<[Data]>()
    
    typealias diffableDataSource = UICollectionViewDiffableDataSource<Int, UIImage>
    
    private var collectionViewDataSource: diffableDataSource!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        configureDataSource()
    }
    
    override func configureLayout() {
        self.navigationItem.hidesBackButton = true
        mainView.collectionView.delegate = self
        mainView.contentTextView.delegate = self
        mainView.addImageButton.addTarget(self, action: #selector(addImageButtonTap), for: .touchUpInside)
    }
    
    private func bind() {
        
        let input = PostViewModel.Input(
            xButton: mainView.xButton.rx.tap,
            postButton: mainView.postButton.rx.tap,
            titleTextField: mainView.titleTextField.rx.text.orEmpty,
            contentTextView: mainView.contentTextView.rx.text.orEmpty, 
            imageRelay: imageRelay
        )
        
        let output = viewModel.transform(input: input)
        
        output.textFieldValidation
            .drive(with: self) { owner, isValid in
                owner.mainView.postButton.backgroundColor = isValid ? .white : .gray
                owner.mainView.postButton.isEnabled = isValid
            }
            .disposed(by: disposeBag)
        
        output.xButtonTap
            .drive(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        output.postButtonTap
            .drive(with: self) { owner, result in
                switch result {
                case true:
                    owner.navigationController?.popViewController(animated: true)
                case false:
                    owner.showAlertMessage(title: "", message: "게시글 작성에 실패했습니다. 다시 시도해 주세요.")
                }
            }
            .disposed(by: disposeBag)
        
        NotificationCenter.default.rx.notification(.accessTokenRefreshFailed)
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, notification in
                owner.navigationController?.popToRootViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    ///Image -> Data 메서드
    private func convertImagesToData(_ images: [UIImage]) -> [Data] {
        return images.map { image in
            return image.jpegData(compressionQuality: 0.2) ?? Data()
        }
    }
    
    ///ActionSheet
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
            configuration.selectionLimit = 5
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
    
    ///CollectionView DataSource
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
    
    ///Snapshot
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, UIImage>()
        snapshot.appendSections([0])
        snapshot.appendItems(selectedImages)
        collectionViewDataSource.apply(snapshot)
        
        let imageDataArray = convertImagesToData(selectedImages)
        imageRelay.accept(imageDataArray)
    }
    
}

//MARK: - CollectionView 컬렉션뷰
extension PostViewController: UICollectionViewDelegate {
    
}

//MARK: - ImagePicker 카메라
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

//MARK: - PHPicker 앨범에서 이미지 가져오기
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

//MARK: - TextView 텍스트뷰
extension PostViewController: UITextViewDelegate {
    
}
