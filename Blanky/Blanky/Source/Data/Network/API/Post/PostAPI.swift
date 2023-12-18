//
//  PostPathAPI.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/28.
//

import Foundation
import Moya

enum PostAPI {
    case postCreate(model: PostCreate) // 게시글 작성
    case postRead(next: String, limit: String, product_id: String) // 게시글 조회
    case onePostRead(id: String, product_id: String) // 특정 게시글 조회
    case postDelete(id: String) // 게시글 삭제
    case postUser(id: String, next: String, limit: String, product_id: String) // 유저별 작성한 게시글 조회
    case commentCreate(id: String, model: CommentInput) // 댓글 작성
    case commentDelete(id: String, commentID: String) // 댓글 삭제
    case like(id: String) // 좋아요
    case likeMe(next: String, limit: String) // 좋아요한 게시글 조회
    case profileMe // 내 프로필 조회
}

extension PostAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: APIKey.baseURL)!
    }
    
    var path: String { // request.parameter
        switch self {
        case .postCreate, .postRead:
            return "post"
        case .postDelete(let id): 
            // 게시글 삭제 - id
            return "post/\(id)"
        case .postUser(let id, _, _, _):
            return "post/user/\(id)"
        case .commentCreate(let id, _):
            // 댓글 작성 - id
            return "post/\(id)/comment"
        case .commentDelete(let id, let commentID):
            // 댓글 삭제 - id, commentID
            return "post/:\(id)/comment/:\(commentID)"
        case .like(let id):
            // 좋아요 - id
            return "post/like/\(id)"
        case .likeMe:
            return "post/like/me"
        case .onePostRead(let id, _):
            // 특정 게시글 조회 - id
            return "post/\(id)"
        case .profileMe:
            // 내 프로필 조회
            return "profile/me"
        }
    }
    
    var method: Moya.Method {
        switch self {
        //POST: 게시글/댓글 작성, 좋아요
        case .postCreate, .commentCreate, .like:
            return .post
        //GET: 게시글 조회, 유저별 작성한 게시글 조회, 특정 게시글 조회, 내 프로필 조회
        case .postRead, .postUser, .likeMe, .onePostRead, .profileMe:
            return .get
        //DEL: 게시글/댓글 삭제
        case .postDelete, .commentDelete:
            return .delete
        }
    }
    
    var task: Moya.Task { //request-query, request-body
        switch self {
        case .postCreate(let model):
            var multipartData: [MultipartFormData] = []
            
            if let file = model.file {
                file.forEach { item in
                    let imageData = MultipartFormData(provider: .data(item), name: "file", fileName: "image_\(UUID().uuidString).jpeg", mimeType: "image/jpeg")
                    multipartData.append(imageData)
                }
            }
            
            let titleData = MultipartFormData(provider: .data(model.title.data(using: .utf8)!), name: "title")
            let contentData = MultipartFormData(provider: .data(model.content.data(using: .utf8)!), name: "content")
            let productIdData = MultipartFormData(provider: .data(model.product_id.data(using: .utf8)!), name: "product_id")
            
            multipartData.append(titleData)
            multipartData.append(contentData)
            multipartData.append(productIdData)
            
            print("PostAPI print: ", multipartData)
            return .uploadMultipart(multipartData)
        case .postRead(let next, let limit, let product_id), .postUser(_, let next, let limit, let product_id):
            let parameters: [String: String] = ["next": next, "limit": limit, "product_id": product_id]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .commentCreate(_, let model):
            return .requestJSONEncodable(model)
        case .postDelete(_), .like(_), .commentDelete(_, _):
            return .requestPlain
        case .likeMe(next: let next, limit: let limit):
            let parameters: [String: String] = ["next": next, "limit": limit]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .onePostRead(_, let product_id):
            let parameters: [String: String] = ["product_id": product_id]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .profileMe:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .postCreate:
            [Constant.authorization: KeychainManager.shared.token ?? "token error",
             Constant.contentType: "multipart/form-data",
             Constant.sesacKey: APIKey.sesacKey]
        case .postRead, .postDelete, .postUser, .commentDelete, .like, .likeMe, .onePostRead, .profileMe:
            [Constant.authorization: KeychainManager.shared.token ?? "token error",
             Constant.sesacKey: APIKey.sesacKey]
        case .commentCreate:
            [Constant.authorization: KeychainManager.shared.token ?? "token error",
             Constant.contentType: "application/json",
             Constant.sesacKey: APIKey.sesacKey]
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
}
