//
//  CxjToastComparisonCriteria.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 14/12/2024.
//

import Foundation

/// Defines the criteria used to compare and identify matching toasts.
///
/// This structure determines whether two toasts should be considered as "matching"
/// based on their attributes and the specified logical operation.
public struct CxjToastComparisonCriteria: Sendable {
    /// A set of attributes used to determine if two toasts match.
	let attibutes: Set<CxjToastComparisonAttribute>
    
    /// The logical operation applied to the attributes to evaluate a match.
	let logicOperation: LogicOperation
	
	public init(
		attibutes: Set<CxjToastComparisonAttribute>,
		rule: LogicOperation
	) {
		self.attibutes = attibutes
		self.logicOperation = rule
	}
}

//MARK: - CxjToastComparisonCriteria + LogicOperation
extension CxjToastComparisonCriteria {
    /// The logical operation used to evaluate matching attributes.
    ///
    /// Determines how the attributes are combined to decide if two toasts match.
    public enum LogicOperation: Sendable {
        /// At least one attribute must match for the comparison to succeed.
        case or
        
        /// All attributes must match for the comparison to succeed.
        case and
    }
}
