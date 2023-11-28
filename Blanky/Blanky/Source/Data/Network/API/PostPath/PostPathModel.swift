//
//  PostPathModel.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/28.
//

import Foundation

// MARK: 게시글 작성/수정
struct PostInput: Encodable {
    let title: String
    let content: String
    let file: Data?
    let product_id: String
    let content1, content2: String?
}

// MARK: 게시글 조회
struct PostOutput: Decodable {
    let data: [PostData]
    let nextCursor: String
}

// MARK: 게시글 작성/수정
struct PostData: Decodable {
    let likes, image: [String]
    let hashTags, comments: [String]
    let id: String
    let creator: Creator
    let time: Date // Date? String?
    let title: String
    let content, content1, content2: String?
    let productID: String
}

struct Creator: Decodable {
    let id, nick, profile: String
}

// MARK: 게시글 삭제
struct PostDeleteOutput: Decodable {
    let _id: String
}

// MARK: 댓글 작성, 수정
struct CommentInput: Encodable {
    let content: String
}

struct CommentOutput: Decodable {
    let id, content, time: String
    let creator: Creator
}

// MARK: 댓글 삭제
struct CommentDeleteOutput: Decodable {
    let postID, commentID: String
}

// MARK: 좋아요
struct LikeOutput: Decodable {
    let like_status: Bool
}
