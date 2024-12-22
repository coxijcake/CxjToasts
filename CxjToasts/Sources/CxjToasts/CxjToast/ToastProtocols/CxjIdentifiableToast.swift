//
//  CxjIdentifiableToast.swift
//  
//
//  Created by Nikita Begletskiy on 29/08/2024.
//

import Foundation

public protocol CxjIdentifiableToast: AnyObject where Self: Equatable & Hashable & Sendable {
	var id: UUID { get }
	var typeId: String { get }
}
