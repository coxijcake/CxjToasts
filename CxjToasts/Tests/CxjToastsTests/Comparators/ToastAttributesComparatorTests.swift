//
//  ToastAttributesComparatorTests.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 21/12/2024.
//

import UIKit
import Testing

@testable import CxjToasts

final class ToastAttributesComparatorTests {
    struct MockComparableToast: ComparableToast {
        let typeId: String
        let placement: Placement
        let sourceView: UIView
    }
    
    @MainActor @Test
    func testIsAllAttributesEqualWithAllMatching() throws {
        let sourceView = UIView()
        
        let lhsToast = MockComparableToast(
            typeId: "unique_id",
            placement: .center,
            sourceView: sourceView
        )
        
        let rhsToast = lhsToast
        
        let comparator = ToastAttributesComparator(
            lhsToast: lhsToast,
            rhsToast: rhsToast,
            comparingAttributes: [.type, .placement(includingYOffset: true), .sourceView]
        )
        
        #expect(comparator.isAllAttributesEqual() == true)
    }
    
    @MainActor @Test
    func testIsAllAttributesEqualWithOneNonMatching() throws {
        let sourceView = UIView()
        
        let lhsToast = MockComparableToast(
            typeId: "id1",
            placement: .center,
            sourceView: sourceView
        )
        
        let rhsToast = MockComparableToast(
            typeId: "id2",
            placement: .center,
            sourceView: sourceView
        )
        
        let comparator = ToastAttributesComparator(
            lhsToast: lhsToast,
            rhsToast: rhsToast,
            comparingAttributes: [.type, .placement(includingYOffset: true), .sourceView]
        )
        
        #expect(comparator.isAllAttributesEqual() == false)
    }
    
    @MainActor @Test
    func testIsOneOfAttributesEqualWithAtLeastOneMatching() throws {
        let lhsSourceView = UIView()
        let rhsSourceView = UIView()
        
        let lhsToast = MockComparableToast(
            typeId: "id1",
            placement: .center,
            sourceView: lhsSourceView
        )
        
        let rhsToast = MockComparableToast(
            typeId: "id1",
            placement: .bottom(params: .init(offset: 0, includingSafeArea: false)),
            sourceView: rhsSourceView
        )
        
        let comparator = ToastAttributesComparator(
            lhsToast: lhsToast,
            rhsToast: rhsToast,
            comparingAttributes: [.type, .placement(includingYOffset: false), .sourceView]
        )
        
        #expect(comparator.isOneOfAttributesEqual() == true)
    }
    
    @MainActor @Test
    func testIsOneOfAttributesEqualWithNoneMatching() throws {
        let lhsSourceView = UIView()
        let rhsSourceView = UIView()
        
        let lhsToast = MockComparableToast(
            typeId: "id1",
            placement: .center,
            sourceView: lhsSourceView
        )
        
        let rhsToast = MockComparableToast(
            typeId: "id2",
            placement: .bottom(params: .init(offset: 0, includingSafeArea: false)),
            sourceView: rhsSourceView
        )
        
        let comparator = ToastAttributesComparator(
            lhsToast: lhsToast,
            rhsToast: rhsToast,
            comparingAttributes: [.type, .placement(includingYOffset: false), .sourceView]
        )
        
        #expect(comparator.isOneOfAttributesEqual() == false)
    }
}
