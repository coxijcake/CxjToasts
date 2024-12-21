//
//  ToastAttributesComparatorTests.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 21/12/2024.
//

import UIKit
import Testing

@testable import CxjToasts

@MainActor
final class ToastAttributesComparatorTests {

    @Test
    func testIsAllAttributesEqualWithAllMatching() throws {
        let lhsValues = ToastAttributesComparator.ComparingValues(
            typeId: "unique_id",
            placement: .center,
            sourceView: UIView()
        )
        
        let rhsValues = lhsValues
        
        let comparator = ToastAttributesComparator(
            lhsToastValues: lhsValues,
            rhsToastValues: rhsValues,
            comparingAttributes: [.type, .placement(includingYOffset: true), .sourceView]
        )
        
        #expect(comparator.isAllAttributesEqual() == true)
    }

    @Test
    func testIsAllAttributesEqualWithOneNonMatching() throws {
        let lhsValues = ToastAttributesComparator.ComparingValues(
            typeId: "id1",
            placement: .center,
            sourceView: UIView()
        )
        
        let rhsValues = ToastAttributesComparator.ComparingValues(
            typeId: "id2",
            placement: .center,
            sourceView: lhsValues.sourceView
        )
        
        let comparator = ToastAttributesComparator(
            lhsToastValues: lhsValues,
            rhsToastValues: rhsValues,
            comparingAttributes: [.type, .placement(includingYOffset: true), .sourceView]
        )
        
        #expect(comparator.isAllAttributesEqual() == false)
    }

    @Test
    func testIsOneOfAttributesEqualWithAtLeastOneMatching() throws {
        let lhsValues = ToastAttributesComparator.ComparingValues(
            typeId: "id1",
            placement: .center,
            sourceView: UIView()
        )
        
        let rhsValues = ToastAttributesComparator.ComparingValues(
            typeId: "id1",
            placement: .bottom(params: .init(offset: 0, includingSafeArea: false)),
            sourceView: UIView()
        )
        
        let comparator = ToastAttributesComparator(
            lhsToastValues: lhsValues,
            rhsToastValues: rhsValues,
            comparingAttributes: [.type, .placement(includingYOffset: false), .sourceView]
        )
        
        #expect(comparator.isOneOfAttributesEqual() == true)
    }

    @Test
    func testIsOneOfAttributesEqualWithNoneMatching() throws {
        let lhsValues = ToastAttributesComparator.ComparingValues(
            typeId: "id1",
            placement: .center,
            sourceView: UIView()
        )
        
        let rhsValues = ToastAttributesComparator.ComparingValues(
            typeId: "id2",
            placement: .bottom(params: .init(offset: 0, includingSafeArea: false)),
            sourceView: UIView()
        )
        
        let comparator = ToastAttributesComparator(
            lhsToastValues: lhsValues,
            rhsToastValues: rhsValues,
            comparingAttributes: [.type, .placement(includingYOffset: false), .sourceView]
        )
        
        #expect(comparator.isOneOfAttributesEqual() == false)
    }
}
