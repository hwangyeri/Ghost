//
//  GhostAPIManager.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/29.
//

import Foundation
import Moya
import RxSwift

final class PostAPIManager {
    
    static let shared = PostAPIManager()
    
    private let provider = MoyaProvider<PostAPI>()
    
    private let disposeBag = DisposeBag()
    
    private init() { }
    
    func request<T: Decodable>(target: PostAPI, model: T.Type) -> Single<Result<T, APIError>> {
        return Single<Result<T, APIError>>.create { single in
            self.provider.request(target) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: response.data)
                        single(.success(.success(decodedData)))
                    } catch {
                        single(.success(.failure(.decodedError)))
                    }
                case .failure(let error):
                    guard let customError = APIError(rawValue: error.response?.statusCode ?? 1) else {
                        single(.success(.failure(.unknownError)))
                        return
                    }
                    single(.success(.failure(customError)))
                }
            }
            return Disposables.create()
        }
    }
    
    // MARK: 게시글 작성
    func postCreate(title: String, content: String, file: [Data]) -> Single<Result<PostCreate, APIError>> {
        let input = PostCreate(title: title, content: content, file: file, product_id: "ghost00")
        return request(target: .postCreate(model: input), model: PostCreate.self)
    }
    
    // MARK: 게시글 조회
    func postRead(next: String, limit: String, product_id: String) -> Single<Result<PostOutput, APIError>> {
        return request(target: .postRead(next: next, limit: limit, product_id: product_id), model: PostOutput.self)
    }
    
    // MARK: 게시글 수정
//    func postUpdate(id: String, title: String, content: String, file: Data, product_id: String, content1: String?, content2: String?) -> Single<Result<PostOutput, APIError>> {
//        let input = PostInput(title: title, content: content, file: file)
//        return request(target: .postUpdate(model: input, id: id), model: PostOutput.self)
//    }
    
    // MARK: 게시글 삭제
    func postDelete(id: String) -> Single<Result<PostDelete, APIError>> {
        return request(target: .postDelete(id: id), model: PostDelete.self)
    }
    
    // MARK: 유저별 작성한 게시글 조회
    func postUser(id: String, next: String, limit: String, product_id: String) -> Single<Result<PostDelete, APIError>> {
        return request(target: .postUser(id: id, next: next, limit: limit, product_id: product_id), model: PostDelete.self)
    }
    
    // MARK: 댓글 작성
    func commentCreate(id: String, content: String) -> Single<Result<CommentOutput, APIError>> {
        let input = CommentInput(content: content)
        return request(target: .commentCreate(model: input, id: id), model: CommentOutput.self)
    }
    
    // MARK: 댓글 수정
    func commentUpdate(id: String, commentID: String, content: String) -> Single<Result<CommentOutput, APIError>> {
        let input = CommentInput(content: content)
        return request(target: .commentUpdate(model: input, id: id, commentID: commentID), model: CommentOutput.self)
    }
    
    // MARK: 댓글 삭제
    func commentDelete(id: String, commentID: String) -> Single<Result<CommentDelete, APIError>> {
        return request(target: .commentDelete(id: id, commentID: commentID), model: CommentDelete.self)
    }
    
    // MARK: 좋아요
    func like(id: String) -> Single<Result<Like, APIError>> {
        return request(target: .like(id: id), model: Like.self)
    }
    
    // MARK: 좋아요한 게시글 조회
    func likeMe(next: String, limit: String) -> Single<Result<PostOutput, APIError>> {
        return request(target: .likeMe(next: next, limit: limit), model: PostOutput.self)
    }
    
}
