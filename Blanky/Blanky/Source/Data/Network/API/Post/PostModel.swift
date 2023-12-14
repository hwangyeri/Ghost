//
//  PostPathModel.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/28.
//

import Foundation

//MARK: - 게시글 작성
struct PostCreate: Codable {
    let title, content: String
    let file: [Data]?
    let product_id: String
}

//MARK: - 게시글 조회
struct PostRead: Decodable, Hashable {
    var data: [PostData]
    var next_cursor: String
}

struct PostData: Decodable, Hashable {
    let likes, image: [String]
    let comments: [Comment]
    let _id, time: String
    let creator: Creator
    let title, content, product_id: String
}

struct Comment: Decodable, Hashable {
    let _id, content, time: String
    let creator: Creator
}

struct Creator: Decodable, Hashable {
    let _id, nick: String
}

// ---- check

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
