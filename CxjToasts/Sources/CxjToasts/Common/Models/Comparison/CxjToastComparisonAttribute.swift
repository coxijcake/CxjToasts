//
//  CxjToastComparisonAttribute.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 14/12/2024.
//

import Foundation

public enum CxjToastComparisonAttribute: Hashable, Sendable {
	public static var recommened: Set<CxjToastComparisonAttribute> {
		[.type, .placement(includingYOffset: true), .sourceView]
	}
	
	case type
	case placement(includingYOffset: Bool)
	case sourceView
}
