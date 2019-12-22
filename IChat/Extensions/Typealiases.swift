//
//  Typealiases.swift
//  IChat
//
//  Created by Алексей Пархоменко on 22.12.2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import Foundation

enum Result<Value> {
    case success(Value)
    case failure(Error)
}

typealias ItemClosure<T> = ((T) -> Void)
typealias OptionalItemClosure<T> = ((T?) -> Void)
typealias VoidClosure = (() -> Void)
typealias ResultHandler<Value> = (Result<Value>) -> Void
