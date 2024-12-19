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
        
        case centerX(offset: CGFloat)
        case centerY(offset: CGFloat)
        
        case width(value: CGFloat)
        case height(value: CGFloat)
    }

    public enum ConstraintValue {
        case equal(value: CGFloat)
        case greaterOrEqual(value: CGFloat)
        case lessOrEqual(value: CGFloat)
    }
}
