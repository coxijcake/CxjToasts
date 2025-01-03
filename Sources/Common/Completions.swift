//
//  Completions.swift
//  
//
//  Created by Nikita Begletskiy on 25/08/2024.
//

import Foundation

public typealias CxjVoidCompletion = () -> Void
public typealias CxjVoidSendableCompletion = @Sendable () -> Void

public typealias CxjBoolCompletion = (Bool) -> Void
public typealias CxjBoolSendableCompletion = @Sendable (Bool) -> Void
