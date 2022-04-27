//
//  ViewModel.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/04/27.
//

import Foundation

import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input, disposeBag: DisposeBag) -> Output
}
