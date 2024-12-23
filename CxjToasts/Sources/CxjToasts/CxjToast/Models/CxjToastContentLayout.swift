//
//  CxjToastContentLayout.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 19/12/2024.
//

import UIKit

public enum CxjToastContentLayout {
    case fill(insets: UIEdgeInsets)
    case constraints(anchors: [Anchor])
}

extension CxjToastContentLayout {
    public enum Anchor {
        case top(value: ConstraintValue)
        case bottom(value: ConstraintValue)
        case left(value: ConstraintValue)
        case right(value: ConstraintValue)
        
        case width(value: ConstraintValue)
        case height(value: ConstraintValue)
        
        case centerX(value: ConstraintValue)
        case centerY(value: ConstraintValue)
    }

    public enum ConstraintValue {
        case equal(value: CGFloat)
        case greaterOrEqual(value: CGFloat)
        case lessOrEqual(value: CGFloat)
    }
}
