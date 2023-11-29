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

// MARK: 게시글 조회, 내가 좋아요 한 포스트 일괄 조회
struct PostOutput: Decodable {
    let data: [PostData]
    let nextCursor: String
}

// MARK: 게시글 작성/수정
struct PostData: Decodable {
    let likes, image: [String]
    let hashTags, comments: [String]
    let id, productID: String
    let creator: Creator
    let time: String
    let title, content: String
    let content1, content2: String?
}

struct Creator: Decodable {
    let id, nick, profile: String
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
