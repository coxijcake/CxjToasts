//
//  CxjToastComparisonAttribute.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 14/12/2024.
//

import Foundation

/// Attributes used to compare and identify matching toasts.
///
/// These attributes define the properties of toasts that are compared
/// to determine whether two toasts are considered as "matching."
public enum CxjToastComparisonAttribute: Hashable, Sendable {
    /// A set of attributes used for complete toast comparison.
    ///
    /// Includes:
    /// - `type`
    /// - `placement(includingYOffset: true)`
    /// - `sourceView`
    public static var completeMatch: Set<CxjToastComparisonAttribute> {
        [.type, .placement(includingYOffset: true), .sourceView]
    }
	
    /// Compares the toast type id.
	case type
    
    // Compares the placement of the toast on the source view.
    ///
    /// - Parameter includingYOffset: If `true`, includes the vertical offset (Y-axis)
    ///   in the comparison; otherwise, ignores the offset.
	case placement(includingYOffset: Bool)
    
    /// Compares whether the toasts are attached to the same source view.
	case sourceView
}
