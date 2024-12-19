//
//  ToastContentNsLayoutConstraintConfigurator.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 19/12/2024.
//

import UIKit

//MARK: - Types
extension ToastContentNsLayoutConstraintConfigurator {
    typealias Layout = CxjToastContentLayout
    typealias Anchor = Layout.Anchor
}

@MainActor
enum ToastContentNsLayoutConstraintConfigurator {
    //MARK: - Configuration
    static func constraintsForLayout(
        _ layout: CxjToastContentLayout,
        forView childView: UIView,
        insideView parentView: UIView
    ) -> [NSLayoutConstraint] {
        switch layout {
        case .fill(let insets):
            return fixedConstraintsWithInsets(
                insets,
                forView: childView,
                insideView: parentView
            )
        case .constraints(let anchors):
            return anchoredConstraintsWithAnchors(
                anchors,
                forView: childView,
                insideView: parentView
            )
        }
    }
}

//MARK: - Private calculations
private extension ToastContentNsLayoutConstraintConfigurator {
    static func fixedConstraintsWithInsets(
        _ insets: UIEdgeInsets,
        forView childView: UIView,
        insideView parentView: UIView
    ) -> [NSLayoutConstraint] {
        return [
            childView.topAnchor.constraint(equalTo: parentView.topAnchor, constant: insets.top),
            childView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -insets.top),
            childView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: insets.left),
            childView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -insets.right)
        ]
    }
    
    static func anchoredConstraintsWithAnchors(
        _ anchors: [Anchor],
        forView childView: UIView,
        insideView parentView: UIView
    ) -> [NSLayoutConstraint] {
        var result: [NSLayoutConstraint] = []
        
        for anchor in anchors {
            let constraint: NSLayoutConstraint = anchoredConstraintWithAcnor(
                anchor,
                forView: childView,
                insideView: parentView
            )
            
            result.append(constraint)
        }
        
        return result
    }
    
    static func anchoredConstraintWithAcnor(
        _ anchor: Anchor,
        forView childView: UIView,
        insideView parentView: UIView
    ) -> NSLayoutConstraint {
        switch anchor {
        case .top(value: let value):
            return nsLayoutConstraintForNsLayoutAnchor(
                childView.topAnchor,
                withValue: value,
                equalToAnchor: parentView.topAnchor
            )
        case .bottom(value: let value):
            return nsLayoutConstraintForNsLayoutAnchor(
                childView.bottomAnchor,
                withValue: value,
                equalToAnchor: parentView.bottomAnchor
            )
        case .left(value: let value):
            return nsLayoutConstraintForNsLayoutAnchor(
                childView.leftAnchor,
                withValue: value,
                equalToAnchor: parentView.leftAnchor
            )
        case .right(value: let value):
            return nsLayoutConstraintForNsLayoutAnchor(
                childView.rightAnchor,
                withValue: value,
                equalToAnchor: parentView.rightAnchor
            )
        case .centerX(offset: let offset):
            return nsLayoutConstraintForNsLayoutAnchor(
                childView.centerXAnchor,
                withValue: .equal(value: offset),
                equalToAnchor: parentView.centerXAnchor
            )
        case .centerY(offset: let offset):
            return nsLayoutConstraintForNsLayoutAnchor(
                childView.centerYAnchor,
                withValue: .equal(value: offset),
                equalToAnchor: parentView.centerYAnchor
            )
        case .width(value: let value):
            return nsLayoutConstraintForNsLayoutAnchor(
                childView.widthAnchor,
                withValue: .equal(value: value),
                equalToAnchor: parentView.widthAnchor
            )
        case .height(value: let value):
            return nsLayoutConstraintForNsLayoutAnchor(
                childView.heightAnchor,
                withValue: .equal(value: value),
                equalToAnchor: parentView.heightAnchor
            )
        }
    }
    
    static func nsLayoutConstraintForNsLayoutAnchor<AnchorType>(
        _ anchorStart: NSLayoutAnchor<AnchorType>,
        withValue value: Layout.ConstraintValue,
        equalToAnchor anchorEnd: NSLayoutAnchor<AnchorType>
    ) -> NSLayoutConstraint {
        switch value {
        case .equal(value: let value):
            anchorStart.constraint(equalTo: anchorEnd, constant: value)
        case .greaterOrEqual(value: let value):
            anchorStart.constraint(lessThanOrEqualTo: anchorEnd, constant: value)
        case .lessOrEqual(value: let value):
            anchorStart.constraint(lessThanOrEqualTo: anchorEnd, constant: value)
        }
    }
}
