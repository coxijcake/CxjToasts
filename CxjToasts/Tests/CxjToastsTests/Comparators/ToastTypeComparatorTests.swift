//
//  ToastTypeComparatorTests.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 21/12/2024.
//

import Foundation
import Testing

@testable import CxjToasts

final class ToastTypeComparatorTests {

    @Test
    func testIsEqualWithSameToastTypeIds() throws {
        let comparator = ToastTypeComparator(lhsToastTypeId: "unique_type_id", rhsToastTypeId: "unique_type_id")
        #expect(comparator.isEqual() == true)
    }

    @Test
    func testIsEqualWithDifferentToastTypeIds() throws {
        let comparator = ToastTypeComparator(lhsToastTypeId: "type_id_1", rhsToastTypeId: "type_id_2")
        #expect(comparator.isEqual() == false)
    }
}
