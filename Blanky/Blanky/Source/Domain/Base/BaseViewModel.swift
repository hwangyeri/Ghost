//
//  BaseViewModel.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/19.
//

import Foundation

protocol BaseViewModel {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
