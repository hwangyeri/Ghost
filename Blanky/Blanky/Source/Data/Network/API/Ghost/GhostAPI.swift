//
//  PostPathAPI.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/28.
//

import Foundation
import Moya

enum GhostAPI {
    case postCreate(model: PostInput) //게시글 작성
    case postRead(model: PostInput) //게시글 조회
    case postUpdate(model: PostInput, id: String) //게시글 수정
    case postDelete(id: String) //게시글 삭제
    case commentCreate(model: CommentInput, id: String) //댓글 작성
    case commentUpdate(model: CommentInput, id: String, commentID: String) //댓글 수정
    case commentDelete(id: String, commentID: String) //댓글 삭제
    case like(id: String) //좋아요
}

extension GhostAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: APIKey.baseURL)!
    }
    
    var path: String {
        switch self {
        case .postCreate, .postRead:
            return "post"
        // 게시글 수정/삭제 - id
        case .postUpdate(_, let id), .postDelete(let id):
            return "post/:\(id)"
        // 댓글 작성 - id
        case .commentCreate(_, let id):
            return "post/:\(id)/comment"
        // 댓글 수정/삭제 - id, commentID
        case .commentUpdate(_, let id, let commentID), .commentDelete(let id, let commentID):
            return "post/:\(id)/comment/:\(commentID)"
        // 좋아요 - id
        case .like(let id):
            return "post/like/:\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        //POST: 게시글/댓글 작성, 좋아요
        case .postCreate, .commentCreate, .like:
            return .post
        //GET: 게시글 조회
        case .postRead:
            return .get
        //PUT: 게시글/댓글 수정
        case .postUpdate, .commentUpdate:
            return .put
        //DEL: 게시글/댓글 삭제
        case .postDelete, .commentDelete:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postCreate(let model), .postRead(let model):
            return .requestJSONEncodable(model)
        case .postUpdate(let model, _):
            return .requestJSONEncodable(model)
        case .commentCreate(let model, _):
            return .requestJSONEncodable(model)
        case .commentUpdate(let model, _, _):
            return .requestJSONEncodable(model)
        case .postDelete(_), .like(_), .commentDelete(_, _):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .postCreate, .postUpdate:
            ["Authorization": "\(KeychainManager.shared.token ?? "token error")",
             "Content-Type": "multipart/form-data",
             "SesacKey": APIKey.sesacKey]
        case .postRead, .postDelete, .commentDelete, .like:
            ["Authorization": "\(KeychainManager.shared.token ?? "token error")",
             "SesacKey": APIKey.sesacKey]
        case .commentCreate, .commentUpdate:
            ["Authorization": "\(KeychainManager.shared.token ?? "token error")",
             "Content-Type": "application/json",
             "SesacKey": APIKey.sesacKey]
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
}
