//
//  ToastContentNsLayoutConstraintConfiguratorTests.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 23/12/2024.
//

#if canImport(Testing)

import UIKit
import Testing
@testable import CxjToasts

@MainActor
final class ToastContentNsLayoutConstraintConfiguratorTests {
    //MARK: - Props
    private let parentView = UIView()
    private let childView = UIView()

    //MARK: - Tests
    @Test
    func testConstraintsForLayoutWithFill() throws {
        let insets = UIEdgeInsets(top: 10, left: 15, bottom: 20, right: 25)
        let layout = CxjToastContentLayout.fill(insets: insets)

        let constraints = ToastContentNsLayoutConstraintConfigurator.constraintsForLayout(
            layout,
            forView: childView,
            insideView: parentView
        )

        #expect(constraints.count == 4)

        #expect(constraints[0].constant == insets.top)
        #expect(constraints[1].constant == insets.left)
        #expect(constraints[2].constant == -insets.bottom)
        #expect(constraints[3].constant == -insets.right)
    }

    @Test
    func testConstraintsForLayoutWithAnchors() throws {
        let anchors: [CxjToastContentLayout.Anchor] = [
            .top(value: .equal(value: 10)),
            .left(value: .greaterOrEqual(value: 5)),
            .width(value: .equal(value: 100))
        ]

        let layout = CxjToastContentLayout.constraints(anchors: anchors)

        let constraints = ToastContentNsLayoutConstraintConfigurator.constraintsForLayout(
            layout,
            forView: childView,
            insideView: parentView
        )

        #expect(constraints.count == anchors.count)

        // Check top anchor
        #expect(constraints[0].constant == 10)
        #expect(constraints[0].relation == .equal)

        // Check left anchor
        #expect(constraints[1].constant == 5)
        #expect(constraints[1].relation == .greaterThanOrEqual)

        // Check width
        #expect(constraints[2].constant == 100)
        #expect(constraints[2].relation == .equal)
    }

    @Test
    func testFixedConstraintsWithInsets() throws {
        let insets = UIEdgeInsets(top: 5, left: 10, bottom: 15, right: 20)
        let constraints = ToastContentNsLayoutConstraintConfigurator.fixedConstraintsWithInsets(
            insets,
            forView: childView,
            insideView: parentView
        )

        #expect(constraints.count == 4)

        #expect(constraints[0].constant == insets.top)
        #expect(constraints[1].constant == insets.left)
        #expect(constraints[2].constant == -insets.bottom)
        #expect(constraints[3].constant == -insets.right)
    }

    @Test
    func testAnchoredConstraintsWithAnchors() throws {
        let anchors: [CxjToastContentLayout.Anchor] = [
            .top(value: .equal(value: 8)),
            .right(value: .lessOrEqual(value: 20.0))
        ]

        let constraints = ToastContentNsLayoutConstraintConfigurator.anchoredConstraintsWithAnchors(
            anchors,
            forView: childView,
            insideView: parentView
        )

        #expect(constraints.count == anchors.count)

        // Check individual constraints
        #expect(constraints[0].constant == 8)
        #expect(constraints[0].relation == .equal)

        #expect(constraints[1].constant == 20.0)
        #expect(constraints[1].relation == .lessThanOrEqual)
    }

    // MARK: - Corner case tests
    @Test
    func testEmptyAnchors() throws {
        let anchors: [CxjToastContentLayout.Anchor] = []

        let constraints = ToastContentNsLayoutConstraintConfigurator.anchoredConstraintsWithAnchors(
            anchors,
            forView: childView,
            insideView: parentView
        )

        #expect(constraints.count == 0)
    }
}


#endif
