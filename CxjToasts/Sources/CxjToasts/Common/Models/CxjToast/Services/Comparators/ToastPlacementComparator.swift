//
//  ToastPlacementComparator.swift
//
//
//  Created by Nikita Begletskiy on 31/08/2024.
//

import Foundation

struct ToastPlacementComparator {
    typealias Placement = CxjToastConfiguration.Layout.Placement
    
    let lhs: Placement
    let rhs: Placement
    
    func isEqualPlacementType() -> Bool {
        switch (lhs, rhs) {
        case (.center, .center): true
        case (.top, .top): true
        case (.bottom, .bottom): true
        default: false
        }
    }
    
    func isFullyEqauls() -> Bool {
        switch (lhs, rhs) {
        case (.center, .center): true
		case (.top(let lhsParams), .top(let rhsParams)): lhsParams == rhsParams
        case (.bottom(let lhsParams), .bottom(let rhsParams)): lhsParams == rhsParams
        default: false
        }
    }
}
