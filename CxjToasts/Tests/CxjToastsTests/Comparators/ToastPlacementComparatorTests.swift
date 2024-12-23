//
//  ToastPlacementComparatorTests.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 21/12/2024.
//

import Testing

@testable import CxjToasts

final class ToastPlacementComparatorTests {
    //MARK: - Types
    typealias Placement = CxjToastConfiguration.Layout.Placement
    
    //MARK: - Tests
    @Test
    func testIsEqualPlacementType() throws {
        let topWithParams1 = Placement.top(params: .init(offset: 10, includingSafeArea: true))
        let topWithParams2 = Placement.top(params: .init(offset: 20, includingSafeArea: false))
        let bottomWithParams = Placement.bottom(params: .init(offset: 15, includingSafeArea: true))
        let center = Placement.center

        #expect(ToastPlacementComparator(lhs: topWithParams1, rhs: topWithParams2).isEqualPlacementType() == true)
        #expect(ToastPlacementComparator(lhs: topWithParams1, rhs: bottomWithParams).isEqualPlacementType() == false)
        #expect(ToastPlacementComparator(lhs: topWithParams1, rhs: center).isEqualPlacementType() == false)
        #expect(ToastPlacementComparator(lhs: bottomWithParams, rhs: center).isEqualPlacementType() == false)
        #expect(ToastPlacementComparator(lhs: center, rhs: center).isEqualPlacementType() == true)
    }
    
    @Test
    func testIsFullyEquals() throws {
        let topParams1 = Placement.top(params: .init(offset: 10, includingSafeArea: true))
        let topParams2 = Placement.top(params: .init(offset: 10, includingSafeArea: true))
        let topParams3 = Placement.top(params: .init(offset: 20, includingSafeArea: false))
        let bottomParams = Placement.bottom(params: .init(offset: 15, includingSafeArea: true))
        let center = Placement.center

        #expect(ToastPlacementComparator(lhs: topParams1, rhs: topParams2).isFullyEqauls() == true)
        #expect(ToastPlacementComparator(lhs: topParams1, rhs: topParams3).isFullyEqauls() == false)
        #expect(ToastPlacementComparator(lhs: topParams1, rhs: bottomParams).isFullyEqauls() == false)
        #expect(ToastPlacementComparator(lhs: topParams1, rhs: center).isFullyEqauls() == false)
        #expect(ToastPlacementComparator(lhs: center, rhs: center).isFullyEqauls() == true)
    }
    
    @Test
    func testCornerCasesForParams() throws {
        let topParams1 = Placement.top(params: .init(offset: 0, includingSafeArea: false))
        let topParams2 = Placement.top(params: .init(offset: 0, includingSafeArea: false))
        let topParams3 = Placement.top(params: .init(offset: 0, includingSafeArea: true))

        #expect(ToastPlacementComparator(lhs: topParams1, rhs: topParams2).isFullyEqauls() == true)
        #expect(ToastPlacementComparator(lhs: topParams1, rhs: topParams3).isFullyEqauls() == false)
    }
    
    @Test
    func testMatchingSameTypeDifferentParams() throws {
        let topParams1 = Placement.top(params: .init(offset: 5, includingSafeArea: true))
        let topParams2 = Placement.top(params: .init(offset: 10, includingSafeArea: false))
        let bottomParams1 = Placement.bottom(params: .init(offset: 5, includingSafeArea: true))
        let bottomParams2 = Placement.bottom(params: .init(offset: 5, includingSafeArea: false))

        #expect(ToastPlacementComparator(lhs: topParams1, rhs: topParams2).isEqualPlacementType() == true)
        #expect(ToastPlacementComparator(lhs: topParams1, rhs: topParams2).isFullyEqauls() == false)
        #expect(ToastPlacementComparator(lhs: bottomParams1, rhs: bottomParams2).isEqualPlacementType() == true)
        #expect(ToastPlacementComparator(lhs: bottomParams1, rhs: bottomParams2).isFullyEqauls() == false)
    }
}
