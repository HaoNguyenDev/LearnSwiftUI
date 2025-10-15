//
//  ViewModelTransformableProtocol.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/10/25.
//

protocol ViewModelTransformableProtocol {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}
