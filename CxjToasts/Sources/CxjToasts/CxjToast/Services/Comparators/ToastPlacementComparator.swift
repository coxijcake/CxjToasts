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
        case (.top(let lhsOffset), .top(let rhsOffset)): lhsOffset == rhsOffset
        case (.bottom(let lhsOffset), .bottom(let rhsOffset)): lhsOffset == rhsOffset
        default: false
        }
    }
}
