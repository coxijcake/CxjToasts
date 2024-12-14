//
//  CxjToastComparisonCriteria.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 14/12/2024.
//

import Foundation

public struct CxjToastComparisonCriteria: Sendable {
	public enum LogicOperation: Sendable {
		case or
		case and
	}
	
	let attibutes: Set<CxjToastComparisonAttribute>
	let logicOperation: LogicOperation
	
	public init(
		attibutes: Set<CxjToastComparisonAttribute> = CxjToastComparisonAttribute.recommened,
		rule: LogicOperation
	) {
		self.attibutes = attibutes
		self.logicOperation = rule
	}
}
