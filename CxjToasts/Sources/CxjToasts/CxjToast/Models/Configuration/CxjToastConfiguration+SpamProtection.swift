//
//  CxjToastConfiguration+SpamProtection.swift
//
//
//  Created by Nikita Begletskiy on 02/11/2024.
//

import Foundation

extension CxjToastConfiguration {
	public enum SpamProtection: Sendable {
		case on(comparisonCriteria: CxjToastComparisonCriteria)
		case off
	}
}
