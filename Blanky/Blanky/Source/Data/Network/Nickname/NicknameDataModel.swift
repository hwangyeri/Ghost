//
//  NicknameDataModel.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/26.
//

import Foundation

struct Nickname: Codable, Hashable {
    let nicknameData: [NicknameData]
}

struct NicknameData: Codable, Hashable {
    let determiners, colors, animals: [String]
}
