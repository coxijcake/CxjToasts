//
//  CxjToastIdentifiable.swift
//  
//
//  Created by Nikita Begletskiy on 29/08/2024.
//

import Foundation

public protocol CxjToastIdentifiable: AnyObject, Hashable {
	var id: UUID { get }
}
