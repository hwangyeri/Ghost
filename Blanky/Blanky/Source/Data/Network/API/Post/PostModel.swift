//
//  PostPathModel.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/28.
//

import Foundation

/// 게시글 작성
struct PostCreate: Codable {
    let title, content: String
    let file: [Data]?
    let product_id: String
}

// MARK: 게시글 작성/수정
struct PostInput: Encodable {
    let title: String
    let content: String
    let file: Data?
    let product_id: String
}

// MARK: 게시글 조회, 내가 좋아요 한 포스트 일괄 조회
struct PostOutput: Decodable {
    let data: [PostData]
    let nextCursor: String
}

// MARK: 게시글 수정
struct PostData: Decodable {
//    let likes, image, hashTags: [String]
//    let comments: Comments
    let id: String
    //let productID: String
    let creator: Creator
    let time: String
    let title, content: String
}

struct Creator: Decodable {
    let id, nick: String
}

struct Comments: Decodable {
    let id, content, time: String
}

// MARK: 게시글 삭제
struct PostDelete: Decodable {
    let _id: String
}

// MARK: 댓글 작성, 수정
struct CommentInput: Encodable {
    let content: String
}

struct CommentOutput: Decodable {
    let id, content: String
    let time: String
    let creator: Creator
}

// MARK: 댓글 삭제
struct CommentDelete: Decodable {
    let postID, commentID: String
}

// MARK: 좋아요
struct Like: Decodable {
    let like_status: Bool
}
