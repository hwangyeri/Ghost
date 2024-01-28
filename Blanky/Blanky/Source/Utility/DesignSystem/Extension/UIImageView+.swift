//
//  UIImageView+.swift
//  Blanky
//
//  Created by Yeri Hwang on 2024/01/28.
//

import UIKit
import Kingfisher

extension UIImageView {
     
    // 이미지 효율적으로 로드하고 표시할 수 있도록 설계
    // 메모리 사용량을 줄이기 위해서 이미지 다운샘플링 처리
    
    func setImage(withURL imageUrl: String, downsamplingSize: CGSize, completionHandler: @escaping ((Result<RetrieveImageResult, KingfisherError>) -> Void)) {
        
        // Header
        let modifier = AnyModifier { request in
            var headers = request
            headers.setValue(KeychainManager.shared.token, forHTTPHeaderField: Constant.authorization)
            headers.setValue(APIKey.sesacKey, forHTTPHeaderField: Constant.sesacKey)
            return headers
        }
        
        // 캐싱 목적으로 원본 이미지 디스크에 저장
        var options: KingfisherOptionsInfo = [
            .cacheOriginalImage
        ]
        
        options.append(.requestModifier(modifier))
        
        // 메모리 사용량을 줄이기 위해서 이미지 다운샘플링 처리
        options.append(.processor(DownsamplingImageProcessor(size: downsamplingSize)))
        
        // 기기 화면에 맞는 배율 지정해서 이미지 품질 향상시킴
        options.append(.scaleFactor(UIScreen.main.scale))
        
        self.kf.setImage(
            with: URL(string: APIKey.baseURL + imageUrl),
            placeholder: UIImage(named: "ghost"),
            options: options,
            completionHandler: { result in
                completionHandler(result)
            }
        )
    }
    
}
